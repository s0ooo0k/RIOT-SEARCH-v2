package io.github.s0ooo0k.tftv2.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.github.cdimascio.dotenv.Dotenv;
import io.github.s0ooo0k.tftv2.controller.SummonerController;
import io.github.s0ooo0k.tftv2.model.dto.LeagueDTO;
import io.github.s0ooo0k.tftv2.model.dto.SummonerDTO;
import io.github.s0ooo0k.tftv2.util.HttpClientUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.Arrays;

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
}
