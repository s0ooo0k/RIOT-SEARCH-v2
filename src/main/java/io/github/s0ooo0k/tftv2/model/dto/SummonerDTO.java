package io.github.s0ooo0k.tftv2.model.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

public record SummonerDTO(
        String id, // encrypted id
        String puuid, // puuid
        String accountId // summoner id
) {
}
