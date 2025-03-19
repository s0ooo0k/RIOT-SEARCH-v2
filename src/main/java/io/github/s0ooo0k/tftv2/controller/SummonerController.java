package io.github.s0ooo0k.tftv2.controller;

import io.github.s0ooo0k.tftv2.model.dto.LeagueDTO;
import io.github.s0ooo0k.tftv2.model.dto.SummonerDTO;
import io.github.s0ooo0k.tftv2.service.RiotService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class SummonerController {
    private final RiotService riotService;

    public SummonerController(RiotService riotService) {
        this.riotService = riotService;
    }


    @GetMapping("/search/*")
    public String getSummonerInfo(@RequestParam String name, @RequestParam String tag, Model model) {
        String puuid = riotService.getPuuid(name, tag);
        SummonerDTO summoner = riotService.getSummoner(puuid);
        LeagueDTO league = riotService.getLeague(summoner.id());

        model.addAttribute("summoner", summoner);
        model.addAttribute("league", league);

        return "result";
    }

}
