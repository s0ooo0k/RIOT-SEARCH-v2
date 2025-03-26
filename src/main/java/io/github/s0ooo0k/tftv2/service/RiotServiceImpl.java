package io.github.s0ooo0k.tftv2.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.github.cdimascio.dotenv.Dotenv;
import io.github.s0ooo0k.tftv2.model.dto.LeagueDTO;
import io.github.s0ooo0k.tftv2.model.dto.MatchSummaryDTO;
import io.github.s0ooo0k.tftv2.model.dto.SummonerDTO;
import io.github.s0ooo0k.tftv2.util.HttpClientUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Service
public class RiotServiceImpl implements RiotService {
    static final Dotenv dotenv = Dotenv.configure().ignoreIfMissing().load();
    private static final String RIOT_API_KEY = dotenv.get("RIOT_API_KEY");
    private static final String RIOT_BASE_URL = "https://kr.api.riotgames.com";
    private final ObjectMapper objectMapper = new ObjectMapper();
    private static final Logger logger = LoggerFactory.getLogger(RiotServiceImpl.class);

    // v1에서 puuid 찾기
    @Override
    public String getPuuid(String name, String tagLine) {

        String url = "https://asia.api.riotgames.com/riot/account/v1/accounts/by-riot-id/"+name+"/"+tagLine;
        logger.info("URL : {}", url);
        try {
            String jsonResponse = HttpClientUtil.callAPI(url);
            return objectMapper.readTree(jsonResponse).get("puuid").asText();
        } catch (Exception e) {
            throw new RuntimeException("puuid 찾기 실패", e);
        }
    }

    // v4에서 id 찾기
    @Override
    public SummonerDTO getSummoner(String puuid) {
        String url = RIOT_BASE_URL +"/lol/summoner/v4/summoners/by-puuid/"+puuid;
        try {
            String jsonResponse = HttpClientUtil.callAPI(url);
            JsonNode rootNode = objectMapper.readTree(jsonResponse); // JSON 파싱

            String id = rootNode.get("id").asText();
            String puuidValue = rootNode.get("puuid").asText();
            String accountId = rootNode.get("accountId").asText();

            return new SummonerDTO(id, puuidValue, accountId);
        } catch (Exception e) {
            throw new RuntimeException("Summoner 조회 실패", e);
        }
    }

    // 티어 검색

    @Override
    public LeagueDTO getLeague(String summonerId) {
        String url = RIOT_BASE_URL +"/tft/league/v1/entries/by-summoner/"+summonerId;
        try {
            String jsonResponse = HttpClientUtil.callAPI(url);
            // League가 [{}, {}] 형태
            LeagueDTO[] leagueArray = objectMapper.readValue(jsonResponse, LeagueDTO[].class);

            if (leagueArray.length == 0) {
                logger.warn("리그 데이터 없음");
                return null;
            }

            // stream을 사용해서 tft만 가져옴
            return Arrays.stream(leagueArray)
                    .filter(league -> {
                        logger.info("🔍 queueType 검사: {}", league.queueType());
                        return "RANKED_TFT".equals(league.queueType());
                    })
                    .findFirst()
                    .orElse(null);
        } catch (Exception e) {
            logger.error("League 정보 조회 실패: {}", e.getMessage(), e);
            throw new RuntimeException("LeagueDTO 찾기 실패", e);
        }
    }

    @Override
    public List<String> getMatchId(String puuid) {
        logger.info("match id 찾기 : {}", puuid);
        String url = "https://asia.api.riotgames.com/tft/match/v1/matches/by-puuid/"+puuid+"/ids?start=0&count=10";
        try {
            String jsonResponse = HttpClientUtil.callAPI(url);
            logger.info("응답 내용: {}", jsonResponse);
            return Arrays.asList(objectMapper.readValue(jsonResponse, String[].class));
        } catch (Exception e) {
            throw new RuntimeException("매치 ID 조회 실패", e);
        }
    }

    @Override
    public List<MatchSummaryDTO> getMatchSummary(String puuid, List<String> matchIds) {
        logger.info("summary 변경");
        List<MatchSummaryDTO> matchSummaries = new ArrayList<>();

        for(String matchId : matchIds){
            try {
                String url = "https://asia.api.riotgames.com/tft/match/v1/matches/" + matchId;
                String jsonResponse = HttpClientUtil.callAPI(url);
                JsonNode root = objectMapper.readTree(jsonResponse);

                // 참여자 중에 내 정보만 출력함
                JsonNode participants = root.path("info").path("participants");
                for (JsonNode participant : participants) {
                    if (participant.get("puuid").asText().equals(puuid)) {
                        int placement = participant.get("placement").asInt();

                        logger.info("순위 {}", placement);// 순위

                        // 게임 종료 시 챔피언
                        List<String> championIds = new ArrayList<>();
                        JsonNode unitsNode = participant.path("units");

                        // 챔피언 없을 때 체킹
                        if (!unitsNode.isMissingNode() && unitsNode.isArray()) {
                            for (JsonNode unit : unitsNode) {
                                String id = unit.has("character_id") ? unit.get("character_id").asText() : null;
                                if (id != null) {
                                    id = id.replace("TFT13_", "").replace("tft13_", "");
                                    String champUrl = "https://ddragon.leagueoflegends.com/cdn/15.6.1/img/champion/" + id + ".png";
                                    championIds.add(champUrl);
                                }
                            }
                        }

                        logger.info("championIds {}", championIds);
                        // 객체로 리스트에 추가
                        matchSummaries.add(new MatchSummaryDTO(placement, championIds));
                        break;
                    }
                }
            } catch (Exception e) {
                logger.error("League 정보 조회 실패: {}", e.getMessage(), e);
                throw new RuntimeException("LeagueDTO 찾기 실패", e);
            }

        }
        return matchSummaries;
    }
}
