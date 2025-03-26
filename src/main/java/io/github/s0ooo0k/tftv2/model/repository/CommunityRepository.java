package io.github.s0ooo0k.tftv2.model.repository;

import io.github.cdimascio.dotenv.Dotenv;
import io.github.s0ooo0k.tftv2.model.dto.CommunityPostDTO;
import org.springframework.stereotype.Repository;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

@Repository
public class CommunityRepository implements JDBCRepository {
    final Dotenv dotenv = Dotenv.configure().ignoreIfMissing().load();
    final String URL = dotenv.get("DB_URL");
    final String USER = dotenv.get("DB_USER");
    final String PASSWORD = dotenv.get("DB_PASSWORD");

    public List<CommunityPostDTO> findAll() throws Exception {
        // 포스트 생성
        List<CommunityPostDTO> posts = new ArrayList<>();
        try (Connection conn = getConnection(URL, USER, PASSWORD)) {
            Statement stmt = conn.createStatement();
            String query = "SELECT * FROM accounts ORDER BY account_id";
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                posts.add(new CommunityPostDTO(
                        rs.getInt("post_id"),
                        rs.getString("summoner_name"),
                        rs.getString("tier"),
                        rs.getString("rank"),
                        rs.getInt("wins"),
                        rs.getInt("losses"),
                        rs.getTimestamp("post_date")
                ));
            }
        }
        return posts;
    }

    public void save(CommunityPostDTO post) throws Exception {
        // 저장
        try (Connection conn = getConnection(URL, USER, PASSWORD)) {
            // SQL 실행 위한 statement
            Statement stmt = conn.createStatement();
            // 쿼리 작성(저장을 위한)
            String query = """
            INSERT INTO community_posts (summoner_name, tier, rank, wins, losses)
            VALUES ('%s', '%s', '%s', %d, %d)
            """.formatted(
                    post.summonerName(),
                    post.tier(),
                    post.rank(),
                    post.wins(),
                    post.losses()
            );
            stmt.executeUpdate(query);
        }
    }

//    public void delete(long id) throws Exception {
//        try (Connection conn = getConnection(URL, USER, PASSWORD)) {
//            Statement stmt = conn.createStatement();
//            String query = "DELETE FROM accounts WHERE account_id = %d".formatted(id); // 숫자는 작은 따옴표 없어도 된다
//            int rowsAffected = stmt.executeUpdate(query);
//            System.out.println("Rows affected: " + rowsAffected);
//        }
//    }
}