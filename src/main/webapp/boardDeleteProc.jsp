<%@ page import="model.BoardDAO" %>
<%@ page import="model.BoardBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <%
        request.setCharacterEncoding("UTF-8");
        String cmpPass = request.getParameter("password");
        int num = Integer.parseInt(request.getParameter("num"));
        BoardDAO bdao = new BoardDAO();
        BoardBean mbean = bdao.getBoard(num);

        if (mbean.getPassword().equals(cmpPass)) {
            bdao.deleteBoard(num);
    %>
    <script type="text/javascript">
        alert("삭제 성공");
        window.location.href = "boardList.jsp";
    </script>
    <%
        }
        else {
    %>
    <script type="text/javascript">
        alert("비밀번호가 다릅니다");
        window.history.back();
    </script>
    <%

        }

    %>
</body>
</html>
