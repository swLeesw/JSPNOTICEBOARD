<%@ page import="model.BoardBean" %>
<%@ page import="model.BoardDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>게시판</title>
</head>
<body>
<%
    int num = Integer.parseInt(request.getParameter("num"));
    BoardDAO bdao = new BoardDAO();
    BoardBean boardBean = bdao.getBoard(num);
%>
<center>
    <h2>게시글 보기</h2>
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
                <input type="button" value="답글쓰기" onclick="location.href='boardReWriteForm.jsp?num=<%=boardBean.getNum()%>&ref=<%=boardBean.getRef()%>&re_step=<%=boardBean.getRe_step()%>&re_level=<%=boardBean.getRe_level()%>'">
                <input type="button" value="수정하기" onclick="location.href='boardUpdateForm.jsp?num=<%=boardBean.getNum()%>'">
                <input type="button" value="삭제하기" onclick="location.href='boardDeleteForm.jsp?num=<%=boardBean.getNum()%>'">
                <input type="button" value="목록보기" onclick="location.href='boardList.jsp'">
            </td>
        </tr>
    </table>
</center>

</body>
</html>
