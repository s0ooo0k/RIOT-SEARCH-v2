<%@ page import="io.github.s0ooo0k.tftv2.model.dto.MatchSummaryDTO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>소환사 정보</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css" >
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style type="text/css">
        @font-face {
            font-family: "KakaoBigSans-ExtraBold";
            src: url("https://fastly.jsdelivr.net/gh/projectnoonnu/2503@1.0/KakaoBigSans-ExtraBold.woff2")
            format("woff2");
            font-weight: 800;
            font-style: normal;
        }

        :root {
            --primary-bg: #091428;
            --secondary-bg: #0a1428;
            --accent-color: #c8aa6e;
            --text-color: #f0e6d2;
            --text-secondary: #a09b8c;
            --card-bg: rgba(10, 20, 40, 0.8);
            --card-border: rgba(200, 170, 110, 0.3);
            --card-shadow: 0 0 20px rgba(200, 170, 110, 0.2);
            --gradient-overlay: linear-gradient(
                    135deg,
                    rgba(9, 20, 40, 0.9),
                    rgba(10, 20, 40, 0.8)
            );
        }

        body {
            background: var(--primary-bg) !important;
            color: var(--text-color);
            font-family: "KakaoBigSans-ExtraBold", sans-serif;
            margin: 0;
            padding: 0;
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
        }

        body::before {
            content: "";
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: var(--gradient-overlay);
            z-index: -1;
        }

        body::after {
            content: "";
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            opacity: 0.1;
            z-index: -1;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .card {
            background: var(--card-bg);
            border: 1px solid var(--card-border);
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 20px;
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
            box-shadow: var(--card-shadow);
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: var(--card-shadow);
        }

        .btn-primary {
            background-color: var(--accent-color);
            border-color: var(--accent-color);
            color: var(--primary-bg);
            font-weight: bold;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            background-color: var(--text-color);
            border-color: var(--text-color);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(200, 170, 110, 0.3);
        }

        .form-control {
            background-color: rgba(240, 230, 210, 0.1);
            border: 1px solid var(--card-border);
            color: var(--text-color);
            padding: 10px;
            border-radius: 5px;
            margin: 5px;
            backdrop-filter: blur(10px);
        }

        .form-control:focus {
            background-color: rgba(240, 230, 210, 0.15);
            border-color: var(--accent-color);
            color: var(--text-color);
            box-shadow: 0 0 0 0.25rem rgba(200, 170, 110, 0.25);
        }

        /* 롤 스타일의 장식 요소 */
        .decorative-line {
            height: 2px;
            background: linear-gradient(
                    90deg,
                    transparent,
                    var(--accent-color),
                    transparent
            );
            margin: 20px 0;
        }

        .decorative-corner {
            position: relative;
        }

        .decorative-corner::before,
        .decorative-corner::after {
            content: "";
            position: absolute;
            width: 20px;
            height: 20px;
            border: 2px solid var(--accent-color);
        }

        .decorative-corner::before {
            top: 0;
            left: 0;
            border-right: none;
            border-bottom: none;
        }

        .decorative-corner::after {
            bottom: 0;
            right: 0;
            border-left: none;
            border-top: none;
        }

        /* 애니메이션 효과 */
        .fade-in {
            opacity: 0;
            transform: translateY(20px);
            animation: fadeIn 0.6s ease forwards;
        }

        @keyframes fadeIn {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* 반응형 디자인 */
        @media (max-width: 768px) {
            .card {
                margin-bottom: 20px;
            }
        }

        /* 커뮤니티 카드 스타일 */
        .community-card {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            padding: 20px;
        }

        .community-card .card {
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
        }

        .community-card .card img {
            width: 100px;
            height: 100px;
            border-radius: 10px;
            margin-bottom: 15px;
        }

        /* 결과 페이지 스타일 */
        .result-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 30px;
        }

        .tier-image {
            width: 100%;
            max-width: 300px;
            border-radius: 10px;
        }

        .match-history {
            margin-top: 30px;
        }

        .match-row {
            background: var(--card-bg);
            border: 1px solid var(--card-border);
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 10px;
            transition: all 0.3s ease;
        }

        .match-row:hover {
            transform: translateX(5px);
            box-shadow: var(--card-shadow);
        }

        /* Three.js 캔버스 스타일 */
        #particle-canvas {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
        }

        h1,
        h2 {
            font-family: "Beaufort for LOL", Arial, sans-serif;
        }

        .result-container {
            min-height: 100vh;
            padding: 40px 20px;
        }

        .result-box {
            background: var(--card-bg);
            padding: 30px;
            border-radius: 15px;
            box-shadow: var(--card-shadow);
            backdrop-filter: blur(10px);
            margin-top: 20px;
        }

        .title {
            color: var(--accent-color);
            font-size: 2.5rem;
            margin-bottom: 30px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
            text-align: center;
        }

        .result-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            align-items: center;
        }

        .tier-image-container {
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .tier-image {
            width: 200px;
            height: 200px;
            border-radius: 10px;
            object-fit: cover;
            box-shadow: 0 0 20px rgba(201, 170, 113, 0.3);
        }

        .tier-info-container {
            text-align: center;
        }

        .tier-info {
            color: var(--accent-color);
            font-size: 2.5rem;
            font-weight: bold;
            margin: 15px 0;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        }

        .win-loss {
            font-size: 1.4rem;
            margin: 20px 0;
            color: var(--text-color);
        }

        .champ-img {
            width: 48px;
            height: 48px;
            margin-right: 6px;
            border-radius: 6px;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        .champ-img:hover {
            transform: scale(1.1);
        }

        .match-row {
            background: var(--card-bg);
            border: 1px solid var(--card-border);
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 10px;
            transition: all 0.3s ease;
        }

        .match-row:hover {
            transform: translateX(5px);
            box-shadow: var(--card-shadow);
        }

        .placement {
            font-weight: bold;
            color: var(--accent-color);
            font-size: 1.2rem;
        }

        .share-button {
            text-align: center;
            margin: 20px 0;
        }

        .alert {
            background: var(--card-bg);
            border: 1px solid var(--card-border);
            color: var(--text-color);
            border-radius: 10px;
            margin: 20px 0;
            padding: 15px;
        }

        .alert-success {
            border-color: #28a745;
        }

        .alert-danger {
            border-color: #dc3545;
        }

        .no-data {
            text-align: center;
            padding: 40px;
            color: var(--accent-color);
            font-size: 1.2rem;
        }

        h3{
            color: white;
        }

        @media (max-width: 768px) {
            .result-grid {
                grid-template-columns: 1fr;
            }

            .tier-image {
                width: 150px;
                height: 150px;
            }

            .tier-info {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
<canvas id="particle-canvas"></canvas>
<div class="main-container">
<%
    String name = (String) request.getAttribute("name");
    String tag = (String) request.getAttribute("tag");
    Object league = request.getAttribute("league");
    java.util.List matchHistory = (java.util.List) request.getAttribute("matchHistory");
%>
<div class="result-container">
    <div class="container">
        <h1 class="title fade-in">소환사 정보</h1>

        <div class="result-box fade-in">
            <% if (league != null) { %>
            <div class="result-grid">
                <div class="tier-image-container">
                    <img src="<%=request.getContextPath()%>${imagePath}" alt="Tier Image" class="tier-image">
                </div>
                <div class="tier-info-container">
                    <h3 class="name-info">${name} #${tag}</h3>
                    <h2 class="tier-info">${league.tier()} ${league.rank()}</h2>
                    <p class="win-loss">승: ${league.wins()} / 패: ${league.losses()}</p>
                    <div class="share-button">
                        <form action="<%=request.getContextPath()%>/community/post" method="post">
                            <input type="hidden" name="summonerName" value="<%=name%>"/>
                            <input type="hidden" name="tier" value="${league.tier()}"/>
                            <input type="hidden" name="rank" value="${league.rank()}"/>
                            <input type="hidden" name="wins" value="${league.wins()}"/>
                            <input type="hidden" name="losses" value="${league.losses()}"/>
                            <button type="submit" class="btn btn-primary">자랑하기</button>
                        </form>
                    </div>
                </div>
            </div>

            <%
                String message = (String) session.getAttribute("message");
                if (message != null) {
                    boolean isError = message.startsWith("실패");
                    String alertClass = isError ? "alert-danger" : "alert-success";
                    String alertMessage = message.replace("성공:", "").replace("실패:", "");
            %>
            <div class="alert <%= alertClass %> alert-dismissible fade show" role="alert">
                <%= alertMessage %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <%
                    session.removeAttribute("message");
                }
            %>

            <% } else { %>
            <div class="no-data">
                <h2>리그 정보 없음</h2>
                <p>해당 소환사의 리그 정보가 없습니다.</p>
            </div>
            <% } %>
            <div class="back-button">
                <a href="${pageContext.request.contextPath}/" class="btn btn-primary">돌아가기</a>
            </div>
        </div>

        <div class="match-history fade-in">
            <h2 class="text-center mb-4">전적 기록</h2>
            <%
                String summonerName = (String) request.getAttribute("name");
                List<MatchSummaryDTO> matches = (List<MatchSummaryDTO>) request.getAttribute("matchHistory");

                if (matches != null && !matches.isEmpty()) {
                    for (MatchSummaryDTO match : matches) {
                        int placement = match.placement();
                        List<String> imgUrls = match.championImg();
            %>
            <div class="match-row">
                <div class="row align-items-center">
                    <div class="col-auto">
                        <span class="placement">[<%= placement %>위]</span>
                    </div>
                    <div class="col">
                        <div class="champion-images">
                            <%
                                if (imgUrls != null) {
                                    for (String img : imgUrls) {
                                        if (img != null && !img.isEmpty()) {
                            %>
                            <img src="<%= img %>" class="champ-img" alt="champion">
                            <%
                                        }
                                    }
                                }
                            %>
                        </div>
                    </div>
                </div>
            </div>
            <%
                }
            } else {
            %>
            <div class="match-row text-center">
                <p class="text-muted">출력할 매치 요약이 없습니다.</p>
            </div>
            <%
                }
            %>
        </div>
    </div>
</div>
</div>

<script>
    console.log("JSP에서 리그 데이터 확인 - ${league}");
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="<%= request.getContextPath() %>/resources/js/common.js"></script>
</body>
</html>
