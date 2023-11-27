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
%>
<jsp:useBean id="boardbean" class="model.BoardBean">
    <jsp:setProperty name="boardbean" property="*"/>
</jsp:useBean>
<%
    BoardDAO bdao = new BoardDAO();
    BoardBean cmpbean = bdao.getBoardUpdate(boardbean.getNum());
    if (cmpbean.getPassword().equals(boardbean.getPassword())) {
        bdao.updateBoard(boardbean);
%>
<script type="text/javascript">
    alert("수정 성공");
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
