package io.github.s0ooo0k.tftv2.util;

import io.github.cdimascio.dotenv.Dotenv;
import io.github.s0ooo0k.tftv2.controller.SummonerController;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

public class HttpClientUtil {
    private static final HttpClient httpClient = HttpClient.newHttpClient();
    static final Dotenv dotenv = Dotenv.configure().ignoreIfMissing().load();
    private static final String RIOT_API_KEY = dotenv.get("RIOT_API_KEY");
    private static final Logger logger = LoggerFactory.getLogger(HttpClientUtil.class);
    public static String callAPI(String url) throws Exception {

        logger.info("API: {}", RIOT_API_KEY);

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .header("X-Riot-Token", RIOT_API_KEY)
                .header("User-Agent", "Mozilla/5.0")
                .header("Accept-Language", "ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7")
                .header("Accept-Charset", "application/x-www-form-urlencoded; charset=UTF-8")
                .GET()
                .build();
        HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());


        logger.info("응답 코드: {}", response.statusCode());


        if (response.statusCode() == 200) {
            return response.body();
        } else {
            logger.error("요청 실패: HTTP error code {}", response.statusCode());
            throw new RuntimeException("Failed : HTTP error code : " + response.statusCode());
        }
    }
}
