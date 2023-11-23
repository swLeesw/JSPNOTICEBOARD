<%@ page import="model.BoardBean" %>
<%@ page import="model.BoardDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    int num = Integer.parseInt(request.getParameter("num"));
    BoardDAO bdao = new BoardDAO();
    BoardBean boardBean = bdao.getBoard(num);
    bdao.addReadCounter(num);
%>
<%=boardBean.getContent()%>

</body>
</html>
