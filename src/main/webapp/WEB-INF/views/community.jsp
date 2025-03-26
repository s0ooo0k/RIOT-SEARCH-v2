<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="io.github.s0ooo0k.tftv2.model.dto.CommunityPostDTO" %>
<!DOCTYPE html>
<html>
<head>
    <title>커뮤니티 게시판</title>
</head>
<body>
<h1>🎮 커뮤니티 게시판</h1>

<div class="card-container">
    <%
        List<CommunityPostDTO> posts = (List<CommunityPostDTO>) request.getAttribute("posts");
        if (posts != null) {
            for (CommunityPostDTO post : posts) {
    %>
    <div class="card">
        <h3><%= post.summonerName() %></h3>
        <p>티어: <%= post.tier() %> <%= post.rank() %></p>
        <img src="<%= request.getContextPath() %><%= post.imagePath()%>" alt="img">
        <p>전적: <%= post.wins() %>승 / <%= post.losses() %>패</p>
        <p>작성일: <%= post.postDate() %></p>
    </div>
    <%
        }
    } else {
    %>
    <p>등록된 게시글이 없습니다.</p>
    <%
        }
    %>
</div>

<a href="${pageContext.request.contextPath}/">← 메인으로 돌아가기</a>
</body>
</html>
