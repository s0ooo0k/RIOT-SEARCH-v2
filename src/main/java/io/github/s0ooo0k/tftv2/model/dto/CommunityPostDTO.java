package io.github.s0ooo0k.tftv2.model.dto;

import java.sql.Timestamp;

public record CommunityPostDTO(
        int postId,
        String summonerName,
        String tier,
        String rank,
        int wins,
        int losses,
        Timestamp postDate
) {
}



//post_id       INT PRIMARY KEY AUTO_INCREMENT,
//summoner_name VARCHAR(255) NOT NULL,
//tier          VARCHAR(50)  NOT NULL,
//rank          VARCHAR(50),
//wins          INT,
//losses        INT,
//post_date     TIMESTAMP DEFAULT CURRENT_TIMESTAMP
