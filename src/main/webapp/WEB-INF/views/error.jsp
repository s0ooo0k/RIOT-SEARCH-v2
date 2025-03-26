<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
  <head>
    <title>에러 발생</title>
    <link href="<%= request.getContextPath() %>/resources/css/common.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
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
