package io.github.s0ooo0k.tftv2.model.dto;

import java.util.List;

public record MatchSummaryDTO(
        int placement, // 순위
        List<String> championImg
) {
}
