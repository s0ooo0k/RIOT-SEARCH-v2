package io.github.s0ooo0k.tftv2.service;

import io.github.s0ooo0k.tftv2.model.dto.LeagueDTO;
import io.github.s0ooo0k.tftv2.model.dto.SummonerDTO;

public class RiotServiceImpl implements RiotService {

    private static final String RIOT_API_KEY = System.getenv("RIOT_API_KEY");
    private static final String RIOT_BASE_URL = System.getenv("https://kr.api.riotgames.com/");

    @Override
    public SummonerDTO getSummoner(String name, String tagLine) {
        return null;
    }

    @Override
    public LeagueDTO getLeague(String summonerId) {
        return null;
    }
}
