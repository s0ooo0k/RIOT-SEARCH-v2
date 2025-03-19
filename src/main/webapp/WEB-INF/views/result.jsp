<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>소환사 정보</title>
</head>
<body>
<h1>소환사 정보</h1>

<% if (request.getAttribute("league") != null) { %>
<h2>리그 정보</h2>
<table>
    <tr>
        <th>티어</th>
        <th>랭크</th>
        <th>승리</th>
        <th>패배</th>
    </tr>
    <tr>
        <td>${league.tier}</td>
        <td>${league.rank}</td>
        <td>${league.wins}</td>
        <td>${league.losses}</td>
    </tr>
</table>
<% } else { %>
<h2>리그 정보 없음</h2>
<p>해당 소환사의 리그 정보가 없습니다.</p>
<% } %>

</body>
</html>