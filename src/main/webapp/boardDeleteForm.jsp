<%@ page import="model.BoardBean" %>
<%@ page import="model.BoardDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>게시판</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
    int num = Integer.parseInt(request.getParameter("num"));
    BoardDAO bdao = new BoardDAO();
    BoardBean boardBean = bdao.getBoardUpdate(num);
%>

<center>
    <h2>게시글 삭제</h2>
    <form action="boardDeleteProc.jsp" method="post">
        <table width="600" border="1" bgcolor="#ffe4b5">
            <tr height="40">
                <td align="center" width="120">글번호</td>
                <td align="center" width="120"><%=boardBean.getNum()%></td>
                <td align="center" width="120">조회수</td>
                <td align="center" width="120"><%=boardBean.getReadCount()%></td>
            </tr>
            <tr height="40">
                <td align="center" width="120">작성자</td>
                <td align="center" width="120"><%=boardBean.getWriter()%></td>
                <td align="center" width="120">작성일</td>
                <td align="center" width="120"><%=boardBean.getReg_date()%></td>
            </tr>
            <tr height="40">
                <td align="center" width="120">패스워드</td>
                <td align="center" colspan="3">
                    <input type="password" name="password" size="48">
                </td>
            </tr>
            <tr height="40">
                <td align="center" width="120">이메일</td>
                <td align="center" colspan="3"><%=boardBean.getEmail()%></td>
            </tr>
            <tr height="40">
                <td align="center" width="120">제목</td>
                <td align="center" colspan="3"><%=boardBean.getSubject()%></td>
            </tr>
            <tr height="150">
                <td align="center" width="120">글 내용</td>
                <td align="center" colspan="3"><%=boardBean.getContent()%></td>
            </tr>
            <tr height="40">
                <td align="center" colspan="4">
                    <input type="hidden" name="num" value="<%=num%>">
                    <input type="submit" value="삭제하기">
                    <input type="button" value="전체 게시글 보기" onclick="window.location.href='boardList.jsp'">
                </td>
            </tr>
        </table>
    </form>
</center>
</body>
</html>
