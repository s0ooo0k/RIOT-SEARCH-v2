package io.github.s0ooo0k.tftv2.service;

import io.github.s0ooo0k.tftv2.model.dto.LeagueDTO;
import io.github.s0ooo0k.tftv2.model.dto.MatchSummaryDTO;
import io.github.s0ooo0k.tftv2.model.dto.SummonerDTO;

import java.util.List;

public interface RiotService {

    String getPuuid(String name, String tagLine); // ACCOUNT-V1
    SummonerDTO getSummoner(String puuid); // SUMMONER-V4
    LeagueDTO getLeague(String summonerId); // TFT LEAGUE-V1

    List<String> getMatchId(String puuid); // TFT MATCH-V1 Match ID목록
    List<MatchSummaryDTO> getMatchSummary(String puuid, List<String> matchIds); // 요약 정보 (placement + 챔피언)
}
