<%@ page import="model.BoardDAO" %>
<%@ page import="model.BoardBean" %>
<%@ page import="java.util.Vector" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>게시판</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
    BoardDAO bdao = new BoardDAO();
    Vector<BoardBean> vec = bdao.getAllBoard();
%>

<center>
    <h2>전체 게시글</h2>
    <table width="700" border="1" bgcolor="#ffe4b5">
        <tr height="40">
            <td align="center" width="50">글 번호</td>
            <td align="center" width="300">제목</td>
            <td align="center" width="100">작성자</td>
            <td align="center" width="150">작성일</td>
            <td align="center" width="50">조회수</td>
        </tr>
        <%
            for (int i = 0; i < vec.size(); i++) {
        %>
        <tr height="40">
            <td align="center" width="150"><%=vec.get(i).getNum()%></td>
            <td width="150">
                <a href="boardInfo.jsp?num=<%=vec.get(i).getNum()%>"><%=vec.get(i).getSubject()%></a></td>
            <td align="center" width="150"><%=vec.get(i).getWriter()%></td>
            <td align="center" width="150"><%=vec.get(i).getReg_date()%></td>
            <td align="center" width="150"><%=vec.get(i).getReadCount()%></td>
        </tr>
        <%
            }
        %>
        <tr height="40">
            <td align="center" colspan="5">
                <input type="button" value="글쓰기" onclick="location.href='boardWriteForm.jsp'">
            </td>
        </tr>
    </table>
</center>


</body>
</html>
