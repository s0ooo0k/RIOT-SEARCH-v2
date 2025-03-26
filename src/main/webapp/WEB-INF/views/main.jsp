<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="io.github.s0ooo0k.tftv2.model.dto.CommunityPostDTO" %>
<html>
  <head>
    <title>TFT TIER</title>
    <link href="<%= request.getContextPath() %>/resources/css/common.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
      .main-container {
        min-height: 100vh;
        padding: 40px 20px;
        display: flex;
        flex-direction: column;
        gap: 40px;
      }
      .search-container {
        display: flex;
        justify-content: center;
        align-items: center;
        text-align: center;
        position: relative;
        z-index: 1;
        margin-bottom: 0;
      }
      .search-box {
        background: var(--card-bg);
        padding: 30px;
        border-radius: 15px;
        box-shadow: var(--card-shadow);
        backdrop-filter: blur(10px);
        max-width: 400px;
        width: 90%;
        border: 1px solid var(--card-border);
        position: relative;
      }
      .search-box::before,
      .search-box::after {
        content: '';
        position: absolute;
        width: 20px;
        height: 20px;
        border: 2px solid var(--accent-color);
      }
      .search-box::before {
        top: 0;
        left: 0;
        border-right: none;
        border-bottom: none;
      }
      .search-box::after {
        bottom: 0;
        right: 0;
        border-left: none;
        border-top: none;
      }
      .title {
        color: var(--text-color);
        font-size: 2.5rem;
        margin-bottom: 25px;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
        position: relative;
      }
      .title::after {
        content: '';
        display: block;
        width: 100px;
        height: 3px;
        background: var(--accent-color);
        margin: 15px auto;
        border-radius: 2px;
      }
      .form-group {
        margin-bottom: 15px;
      }
      .form-group label {
        display: block;
        margin-bottom: 8px;
        color: var(--text-color);
        font-size: 1.1rem;
      }
      .community-section {
        width: 100%;
        max-width: 1200px;
        margin: 0 auto;
        position: relative;
      }
      .section-title {
        color: var(--text-color);
        font-size: 2rem;
        margin-bottom: 30px;
        text-align: center;
        position: relative;
      }
      .section-title::after {
        content: '';
        display: block;
        width: 80px;
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
      }
      .community-card .card {
        aspect-ratio: 1;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        text-align: center;
        padding: 15px;
        background: rgba(240, 230, 210, 0.1);
        border: 1px solid var(--card-border);
        backdrop-filter: blur(10px);
        position: relative;
        overflow: hidden;
        box-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
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
        width: 150px;
        height: 150px;
        border-radius: 10px;
        margin-bottom: 10px;
        object-fit: cover;
        border: 2px solid var(--accent-color);
        box-shadow: 0 0 15px rgba(200, 170, 110, 0.2);
      }
      .community-card .card h3 {
        font-size: 1.2rem;
        margin-bottom: 8px;
        color: var(--text-color);
      }
      .community-card .card .tier-info {
        font-size: 1.1rem;
        margin: 3px 0;
        color: var(--accent-color);
        font-weight: bold;
        text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.3);
      }
      .community-card .card .win-loss {
        font-size: 1rem;
        margin: 3px 0;
        color: var(--text-color);
        text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.3);
      }
      .community-card .card .post-date {
        font-size: 0.9rem;
        margin-top: 5px;
        color: var(--text-color);
        opacity: 0.9;
        text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.3);
      }
      .community-link {
        text-align: center;
        margin-top: 30px;
      }
      .community-link .btn {
        background: var(--accent-color);
        border: none;
        padding: 10px 25px;
        font-weight: bold;
        transition: all 0.3s ease;
      }
      .community-link .btn:hover {
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
    <canvas id="particle-canvas"></canvas>
    <div class="main-container">
      <div class="search-container">
        <div class="search-box fade-in">
          <h1 class="title">TFT TIER</h1>
          <form action="search" method="get">
            <div class="form-group">
              <label>소환사 이름</label>
              <input type="text" name="name" class="form-control" required />
            </div>
            <div class="form-group">
              <label>소환사 태그(#빼고 입력)</label>
              <input type="text" name="tag" class="form-control" required />
            </div>
            <button type="submit" class="btn btn-primary">검색</button>
          </form>
        </div>
      </div>

      <div class="community-section">
        <h2 class="section-title">Hall of Fame</h2>
        <div class="community-card">
          <%
            List<CommunityPostDTO> posts = (List<CommunityPostDTO>) request.getAttribute("posts");
            int count = 0;
            if (posts != null) {
              for (CommunityPostDTO post : posts) {
                if (count++ >= 9) break;
          %>
          <div class="card fade-in">
            <h3><%= post.summonerName() %></h3>
            <img src="<%= request.getContextPath() %><%= post.imagePath()%>" alt="티어 이미지">
            <p class="tier-info"><%= post.tier() %> <%= post.rank() %></p>
            <p class="win-loss">승: <%= post.wins() %> / 패: <%= post.losses() %></p>
            <small class="post-date"><%= post.postDate() %></small>
          </div>
          <%
            }
          }
          %>
        </div>
        <div class="community-link">
          <a href="<%= request.getContextPath() %>/community" class="btn btn-primary">커뮤니티 전체 보기</a>
        </div>
      </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="<%= request.getContextPath() %>/resources/js/common.js"></script>
  </body>
</html>
