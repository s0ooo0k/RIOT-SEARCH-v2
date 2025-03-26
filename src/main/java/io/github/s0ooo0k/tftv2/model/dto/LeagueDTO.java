package io.github.s0ooo0k.tftv2.model.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public record LeagueDTO(
        String queueType,
        String tier,
        String rank,
        int wins,
        int losses,
        String puuid
) {
}
