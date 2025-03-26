<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="io.github.s0ooo0k.tftv2.model.dto.CommunityPostDTO" %>
<!DOCTYPE html>
<html>
<head>
    <title>Hall of Fame</title>
    <link href="<%= request.getContextPath() %>/resources/css/common.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        .community-container {
            min-height: 100vh;
            padding: 40px 20px;
            position: relative;
        }
        .page-title {
            color: var(--text-color);
            font-size: 2.5rem;
            margin-bottom: 40px;
            text-align: center;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
            position: relative;
        }
        .page-title::after {
            content: '';
            display: block;
            width: 100px;
            height: 3px;
            background: var(--accent-color);
            margin: 15px auto;
            border-radius: 2px;
        }
        .community-card {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            padding: 0 20px;
            max-width: 1200px;
            margin: 0 auto;
        }
        .community-card .card {
            aspect-ratio: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            padding: 15px;
            position: relative;
            overflow: hidden;
            background: var(--card-bg);
            border: 1px solid var(--card-border);
            backdrop-filter: blur(10px);
        }
        .community-card .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(45deg, transparent, rgba(200, 170, 110, 0.1), transparent);
            transform: translateX(-100%);
            transition: transform 0.6s;
        }
        .community-card .card:hover::before {
            transform: translateX(100%);
        }
        .community-card .card img {
            width: 120px;
            height: 120px;
            border-radius: 10px;
            margin-bottom: 15px;
            object-fit: cover;
            border: 2px solid var(--accent-color);
            box-shadow: 0 0 15px rgba(200, 170, 110, 0.2);
        }
        .community-card .card h3 {
            font-size: 1.2rem;
            margin-bottom: 10px;
            color: var(--text-color);
        }
        .community-card .card .tier-info {
            font-size: 1.1rem;
            margin: 5px 0;
            color: var(--accent-color);
            font-weight: bold;
        }
        .community-card .card .win-loss {
            font-size: 1rem;
            margin: 5px 0;
            color: var(--text-secondary);
        }
        .community-card .card .post-date {
            font-size: 0.9rem;
            margin-top: auto;
            color: var(--text-secondary);
            opacity: 0.8;
        }
        .back-link {
            text-align: right;
            margin-top: 40px;
            padding-right: 20px;
        }
        .back-link .btn {
            background: var(--accent-color);
            border: none;
            padding: 10px 25px;
            font-weight: bold;
            transition: all 0.3s ease;
        }
        .back-link .btn:hover {
            background: var(--text-color);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(200, 170, 110, 0.3);
        }
        @media (max-width: 992px) {
            .community-card {
                grid-template-columns: repeat(2, 1fr);
            }
        }
        @media (max-width: 576px) {
            .community-card {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="community-container">
        <div class="container">
            <h1 class="page-title fade-in">Hall of Fame</h1>
            
            <div class="community-card">
                <%
                    List<CommunityPostDTO> posts = (List<CommunityPostDTO>) request.getAttribute("posts");
                    if (posts != null) {
                        for (CommunityPostDTO post : posts) {
                %>
                    <div class="card fade-in">
                        <h3><%= post.summonerName() %></h3>
                        <img src="${pageContext.request.contextPath}<%= post.imagePath()%>" alt="티어 이미지">
                        <p class="tier-info"><%= post.tier() %> <%= post.rank() %></p>
                        <p class="win-loss">승: <%= post.wins() %> / 패: <%= post.losses() %></p>
                        <small class="post-date"><%= post.postDate() %></small>
                    </div>
                <%
                        }
                    } else {
                %>
                    <div class="card fade-in">
                        <p class="text-center">등록된 게시글이 없습니다.</p>
                    </div>
                <%
                    }
                %>
            </div>

            <div class="back-link">
                <a href="${pageContext.request.contextPath}/" class="btn btn-primary">← 메인으로 돌아가기</a>
            </div>
        </div>
    </div>

    <script>
        console.log("📄 community.jsp 로드 완료");
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="<%= request.getContextPath() %>/resources/js/common.js"></script>
</body>
</html>
