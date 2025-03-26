<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>Summoner Search</title>
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
      .search-container {
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        text-align: center;
      }
      .search-box {
        background: rgba(10, 20, 40, 0.9);
        padding: 40px;
        border-radius: 15px;
        box-shadow: 0 0 30px rgba(201, 170, 113, 0.3);
        backdrop-filter: blur(10px);
        max-width: 500px;
        width: 90%;
      }
      .title {
        color: var(--secondary-color);
        font-size: 2.5rem;
        margin-bottom: 30px;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
      }
      .form-group {
        margin-bottom: 20px;
      }
      .form-group label {
        display: block;
        margin-bottom: 8px;
        color: var(--secondary-color);
      }
    </style>
  </head>
  <body>
    <div class="search-container">
      <div class="search-box fade-in">
        <h1 class="title">소환사 검색</h1>
        <form action="search" method="get">
          <div class="form-group">
            <select name="languages">
              <option value="lol" name="lol">League of Legend</option>
              <option value="tft" name="tft">TFT</option>
            </select>
          </div>
          <div class="form-group">
            <label>Summoner name</label>
            <input type="text" name="name" class="form-control" required />
          </div>
          <div class="form-group">
            <label>Summoner tag</label>
            <input type="text" name="tag" class="form-control" required />
          </div>
          <button type="submit" class="btn btn-primary">검색</button>
        </form>
      </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="<%= request.getContextPath() %>/resources/js/common.js"></script>
  </body>
</html>
