<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>소환사 정보</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link
      href="https://fonts.googleapis.com/css2?family=Beaufort+for+LOL:wght@400;700&display=swap"
      rel="stylesheet"
    />
    <link
      href="<%= request.getContextPath() %>/resources/css/common.css"
      rel="stylesheet"
    />
    <style>
      .result-container {
        min-height: 100vh;
        padding: 40px 20px;
      }
      .result-box {
        background: rgba(10, 20, 40, 0.9);
        padding: 30px;
        border-radius: 15px;
        box-shadow: 0 0 30px rgba(201, 170, 113, 0.3);
        backdrop-filter: blur(10px);
        margin-top: 20px;
      }
      .title {
        color: var(--secondary-color);
        font-size: 2.5rem;
        margin-bottom: 30px;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
        text-align: center;
      }
      .table {
        color: var(--text-color);
        background: rgba(255, 255, 255, 0.1);
        border-radius: 10px;
        overflow: hidden;
      }
      .table th {
        background-color: var(--secondary-color);
        color: var(--primary-color);
        border: none;
      }
      .table td {
        border-color: rgba(201, 170, 113, 0.2);
      }
      .no-data {
        text-align: center;
        padding: 40px;
        color: var(--secondary-color);
        font-size: 1.2rem;
      }
      .back-button {
        margin-top: 20px;
        text-align: center;
      }
    </style>
  </head>
  <body>
    <%
      String name = (String) request.getAttribute("name");
      String tag = (String) request.getAttribute("tag");
      Object league = request.getAttribute("league");
    %>
    <div class="result-container">
      <div class="container">
        <h1 class="title fade-in">소환사 정보</h1>
        <div class="result-box fade-in">
          <% if (league != null) { %>
          <h2 class="text-center mb-4">League info</h2>
            <p>경로 : ${imagePath}</p>
          <img src="<%= request.getContextPath() %>${imagePath}" alt="Tier Image">
          <p>티어: ${league.tier()} ${league.rank()}</p>
          <p>승: ${league.wins()}  / 패: ${league.losses()}</p>

          <form action="<%= request.getContextPath() %>/community/post" method="post">
            <input type="hidden" name="summonerName" value="<%= name %>" />
            <input type="hidden" name="tier" value="${league.tier()}" />
            <input type="hidden" name="rank" value="${league.rank()}" />
            <input type="hidden" name="wins" value="${league.wins()}" />
            <input type="hidden" name="losses" value="${league.losses()}" />
            <button type="submit">자랑하기</button>
          </form>
<%--          <div class="table-responsive">--%>
<%--            <table class="table">--%>
<%--              <thead>--%>
<%--                <tr>--%>
<%--                  <th>Tier</th>--%>
<%--                  <th>Rank</th>--%>
<%--                  <th>Win</th>--%>
<%--                  <th>lose</th>--%>
<%--                </tr>--%>
<%--              </thead>--%>
<%--              <tbody>--%>
<%--                <tr>--%>
<%--                  <td>${league.tier()}</td>--%>
<%--                  <td>${league.rank()}</td>--%>
<%--                  <td>${league.wins()}</td>--%>
<%--                  <td>${league.losses()}</td>--%>
<%--                </tr>--%>
<%--              </tbody>--%>
<%--            </table>--%>
<%--          </div>--%>
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
      </div>
    </div>
    <script>
      console.log("JSP에서 리그 데이터 확인 - ${league}");
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="<%= request.getContextPath() %>/resources/js/common.js"></script>
  </body>
</html>
