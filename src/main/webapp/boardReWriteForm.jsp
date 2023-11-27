<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>게시판</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
    //num, ref, re_step, re_level
    int num = Integer.parseInt(request.getParameter("num"));
    int ref = Integer.parseInt(request.getParameter("ref"));
    int re_step = Integer.parseInt(request.getParameter("re_step"));
    int re_level = Integer.parseInt(request.getParameter("re_level"));

%>
<center>
    <h2>답변글 입력하기</h2>

    <form action="boardReWriteProc.jsp" method="post">
        <table width="600" border="1" bgcolor="#ffe4b5">
            <tr height="40">
                <td width="150" align="center">작성자</td>
                <td width="450"><input type="text" name="writer" size="60"></td>
            </tr>
            <tr height="40">
                <td width="150" align="center">제목</td>
                <td width="450"><input type="text" name="subject" value="    [답변]" size="60"></td>
            </tr>
            <tr height="40">
                <td align="center" width="150">이메일</td>
                <td width="450"><input type="email" name="email" size="60"></td>
            </tr>
            <tr height="40">
                <td align="center" width="150">비밀번호</td>
                <td width="450"><input type="password" name="password" size="60"></td>
            </tr>
            <tr height="40">
                <td align="center" width="150">글내용</td>
                <td width="450"><textarea rows="10" cols="58" name="content"></textarea> </td>
            </tr>
            <tr height="40">
                <td align="center" colspan="2">
                    <input type="hidden" name="ref" value="<%=ref%>">
                    <input type="hidden" name="re_step" value="<%=re_step%>">
                    <input type="hidden" name="re_level" value="<%=re_level%>">
                    <input type="submit" value="글쓰기">&nbsp;&nbsp;
                    <input type="reset" value="다시작성">&nbsp;&nbsp;
                    <input type="button" value="전체 게시글 보기" onclick="location.href='boardList.jsp'">
                </td>
            </tr>
        </table>
    </form>

</center>


</body>
</html>
