package io.github.s0ooo0k.tftv2.model.dto;

public record LeagueDTO(
        String queueType,
        String tier,
        String rank,
        int wins,
        int losses
) {
}
