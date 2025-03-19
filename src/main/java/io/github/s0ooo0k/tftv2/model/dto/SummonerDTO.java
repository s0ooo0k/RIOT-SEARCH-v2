package io.github.s0ooo0k.tftv2.model.dto;

public record SummonerDTO(
        String id, // encrypted id
        String puuid, // puuid
        String accountID, // summoner id
        String tagLine, // tagline
        String name // name
) {
}
