CREATE TABLE community_posts
(
    post_id       INT PRIMARY KEY AUTO_INCREMENT,
    summoner_name VARCHAR(255) NOT NULL,
    tier          VARCHAR(50)  NOT NULL,
    `rank`          VARCHAR(50),
    wins          INT,
    losses        INT,
    image_path  VARCHAR(255),
    post_date     TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
