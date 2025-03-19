package io.github.s0ooo0k.tftv2.service;

import io.github.s0ooo0k.tftv2.model.dto.LeagueDTO;
import io.github.s0ooo0k.tftv2.model.dto.SummonerDTO;

public interface RiotService {

    String getPuuid(String name, String tagLine); // ACCOUNT-V1
    SummonerDTO getSummoner(String puuid); // SUMMONER-V4
    LeagueDTO getLeague(String summonerId); // TFT LEAGUE-V1
}
