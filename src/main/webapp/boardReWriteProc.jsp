<%@ page import="model.BoardDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="boardBean" class="model.BoardBean">
    <jsp:setProperty name="boardBean" property="*"/>
</jsp:useBean>

<%
    BoardDAO bdao = new BoardDAO();
    bdao.reWriteBoard(boardBean);

    response.sendRedirect("boardList.jsp");
%>

</body>
</html>
