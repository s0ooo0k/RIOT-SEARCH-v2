package io.github.s0ooo0k.tftv2.service;

import io.github.s0ooo0k.tftv2.model.dto.LeagueDTO;
import io.github.s0ooo0k.tftv2.model.dto.SummonerDTO;

public interface RiotService {
    SummonerDTO getSummoner(String name, String tagLine);
    LeagueDTO getLeague(String summonerId);
}
