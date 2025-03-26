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
        String url = RIOT_BASE_URL + "/tft/match/v1/matches/by-puuid/"+puuid+"/ids?start=0&count=10";
        try {
            String jsonResponse = HttpClientUtil.callAPI(url);
            return Arrays.asList(objectMapper.readTree(jsonResponse).get("matchId").asText());
        } catch (Exception e) {
            throw new RuntimeException("매치 ID 조회 실패", e);
        }
    }

    @Override
    public List<MatchSummaryDTO> getMatchSummary(String puuid, List<String> matchIds) {
        List<MatchSummaryDTO> matchSummaries = new ArrayList<>();

        for(String matchId : matchIds){
            try {
                String url = RIOT_BASE_URL + "/tft/match/v1/matches/" + matchId;
                String jsonResponse = HttpClientUtil.callAPI(url);
                JsonNode root = objectMapper.readTree(jsonResponse);

                // /{
                //    "metadata": {
                //        "data_version": "6",
                //        "match_id": "KR_7572717067",
                //        "participants": [ "멤버", "멤버"...]
                //     ]
                //    },
                //    "info": {
                //        "endOfGameResult": "GameComplete",
                //        "gameCreation": 1742839409000,
                //        "gameId": 7572717067,
                //        "game_datetime": 1742841303943,
                //        "game_length": 1881.3118896484375,
                //        "game_version": "Linux Version 15.6.667.3303 (Mar 21 2025/10:39:25) [PUBLIC] ",
                //        "mapId": 22,
                //        "participants": [
                //            {
                //                "companion": {
                //                    "content_ID": "ead6ac92-a15e-44c0-9826-eb83eb2dbe57",
                //                    "item_ID": 44002,
                //                    "skin_ID": 2,
                //                    "species": "PetChibiLeeSin"
                //                },
                //                "gold_left": 6,
                //                "last_round": 33,
                //                "level": 10,
                //                "missions": {
                //                    "PlayerScore2": 186
                //                },
                //                "placement": 3,
                //                "players_eliminated": 0,
                //                "puuid": "OnSwssAdu0LNQm-yepnYozdRiFxc2F46Vqf4s4UGUH-j9g-iZDnCvyH7hjmM3lTfDqkhdBKy404oUw",
                //                "riotIdGameName": "",
                //                "riotIdTagline": "KR1",
                //                "time_eliminated": 1862.780029296875,
                //                "total_damage_to_players": 127,
                //                "traits": [
                //                    {
                //                        "name": "TFT13_Academy",
                //                        "num_units": 1,
                //                        "style": 0,
                //                        "tier_current": 0,
                //                        "tier_total": 4
                //                    },
                //                    {
                //                        "name": "TFT13_Ambusher",
                //                        "num_units": 1,
                //                        "style": 0,
                //                        "tier_current": 0,
                //                        "tier_total": 4
                //                    },


                // stream을 사용해서 tft만 가져옴

                // 참여자 중에 내 정보만 출력함
                JsonNode participants = root.path("info").path("participants");
                for (JsonNode participant : participants) {
                    if (participant.get("puuid").asText().equals(puuid)) {
                        int placement = participant.get("placement").asInt(); // 순위

                        // 게임 종료 시 챔피언
                        List<String> championIds = new ArrayList<>();
                        for (JsonNode unit : participant.path("units")) {
                            String id = unit.get("character_id").asText()
                                    .replace("TFT13_", "") // 이미지 위해서 TFT13_지우기
                                    .replace("tft13_", ""); // 소문자도 함께 처리
                            championIds.add(id); // 순수 챔피언 이름만 저장
                        }

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
