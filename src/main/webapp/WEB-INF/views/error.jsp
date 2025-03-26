<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
  <head>
    <title>에러 발생</title>
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

      .error-container {
        min-height: 100vh;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        text-align: center;
        padding: 20px;
      }
      .error-title {
        color: var(--text-color);
        font-size: 3rem;
        margin-bottom: 20px;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
        position: relative;
      }
      .error-title::after {
        content: "";
        display: block;
        width: 100px;
        height: 3px;
        background: var(--accent-color);
        margin: 15px auto;
        border-radius: 2px;
      }
      .error-message {
        color: var(--text-color);
        font-size: 1.2rem;
        margin-bottom: 30px;
        text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.3);
      }
      .error-box {
        background: rgba(240, 230, 210, 0.1);
        padding: 30px;
        border-radius: 15px;
        box-shadow: var(--card-shadow);
        backdrop-filter: blur(10px);
        border: 1px solid var(--card-border);
        position: relative;
        max-width: 500px;
        width: 90%;
      }
      .error-box::before,
      .error-box::after {
        content: "";
        position: absolute;
        width: 20px;
        height: 20px;
        border: 2px solid var(--accent-color);
      }
      .error-box::before {
        top: 0;
        left: 0;
        border-right: none;
        border-bottom: none;
      }
      .error-box::after {
        bottom: 0;
        right: 0;
        border-left: none;
        border-top: none;
      }
      .back-button {
        margin-top: 20px;
      }
      .back-button .btn {
        background: var(--accent-color);
        border: none;
        padding: 10px 25px;
        font-weight: bold;
        transition: all 0.3s ease;
      }
      .back-button .btn:hover {
        background: var(--text-color);
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(200, 170, 110, 0.3);
      }
    </style>
  </head>
  <body>
    <div class="error-container">
      <div class="error-box fade-in">
        <h1 class="error-title">에러 발생</h1>
        <p class="error-message">
          죄송합니다. 문제가 발생했습니다.<br />다시 시도해 주세요.
        </p>
        <div class="back-button">
          <a href="${pageContext.request.contextPath}/" class="btn btn-primary"
            >메인으로 돌아가기</a
          >
        </div>
      </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="<%= request.getContextPath() %>/resources/js/common.js"></script>
  </body>
</html>
