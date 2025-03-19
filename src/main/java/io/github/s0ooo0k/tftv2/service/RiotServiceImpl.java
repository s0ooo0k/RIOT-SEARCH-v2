package io.github.s0ooo0k.tftv2.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.github.s0ooo0k.tftv2.model.dto.LeagueDTO;
import io.github.s0ooo0k.tftv2.model.dto.SummonerDTO;
import io.github.s0ooo0k.tftv2.util.HttpClientUtil;
import org.springframework.stereotype.Service;

import java.util.Arrays;

@Service
public class RiotServiceImpl implements RiotService {

    private static final String RIOT_API_KEY = System.getenv("RIOT_API_KEY");
    private static final String RIOT_BASE_URL = System.getenv("https://kr.api.riotgames.com");
    private final ObjectMapper objectMapper = new ObjectMapper();

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

    @Override
    public SummonerDTO getSummoner(String puuid) {
        String url = RIOT_BASE_URL +"/lol/summoner/v4/summoners/by-puuid/"+puuid;
        try {
            String jsonResponse = HttpClientUtil.callAPI(url);
            return objectMapper.readValue(jsonResponse, SummonerDTO.class);

        } catch (Exception e) {
            throw new RuntimeException("SummorID 찾기 실패", e);
        }
    }

    @Override
    public LeagueDTO getLeague(String summonerId) {
        String url = RIOT_BASE_URL +"/tft/league/v1/entries/by-summoner/"+summonerId;
        try {
            String jsonResponse = HttpClientUtil.callAPI(url);
            // League가 [{}, {}] 형태
            LeagueDTO[] leagueArray = objectMapper.readValue(jsonResponse, LeagueDTO[].class);

            // stream을 사용해서 tft만 가져옴
            return Arrays.stream(leagueArray)
                    .filter(league -> "RANKED_TFT".equals(league.queueType()))
                    .findFirst().orElse(null);
        } catch (Exception e) {
            throw new RuntimeException("LeagueDTO 찾기 실패", e);
        }
    }
}
