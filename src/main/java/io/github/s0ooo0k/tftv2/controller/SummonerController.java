package io.github.s0ooo0k.tftv2.controller;

import io.github.s0ooo0k.tftv2.model.dto.LeagueDTO;
import io.github.s0ooo0k.tftv2.model.dto.MatchSummaryDTO;
import io.github.s0ooo0k.tftv2.model.dto.SummonerDTO;
import io.github.s0ooo0k.tftv2.service.RiotService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class SummonerController {

    private static final Logger logger = LoggerFactory.getLogger(SummonerController.class);
    private final RiotService riotService;

    public SummonerController(RiotService riotService) {
        this.riotService = riotService;
    }


    @GetMapping("/search")
    public String getSummonerInfo(@RequestParam("name") String name, @RequestParam("tag") String tag, Model model) {
        String puuid = riotService.getPuuid(name, tag);

        // puuid 받기
        SummonerDTO summoner = riotService.getSummoner(puuid);
        // summoner id 받기
        LeagueDTO league = riotService.getLeague(summoner.id());
        // 이미지 티어
        String imagePath = "/resources/static/tier/"+league.tier()+".png";
        // match 전적 가져오기
        List<String> matchIds = riotService.getMatchId(puuid);
        List<MatchSummaryDTO> matchHistory = riotService.getMatchSummary(puuid, matchIds);
        // logger.info("🦔🦔🦔🦔🦔 {}", matchHistory);

        if (league != null) {
            logger.info("리그 데이터 - Tier: {}, Rank: {}, Wins: {}, Losses: {}",
                    league.tier(), league.rank(), league.wins(), league.losses());
        } else {
            logger.warn("리그 null.");
        }

        model.addAttribute("summoner", summoner);
        model.addAttribute("league", league);


        model.addAttribute("name", name);
        model.addAttribute("tag", tag);

        model.addAttribute("imagePath", imagePath);
        model.addAttribute("matchHistory", matchHistory);

        return "result";
    }




}
