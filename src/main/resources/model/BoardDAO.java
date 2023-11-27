package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

//오라클 데이터 베이스에 연결하고  select, insert, update, delete작업을 실행해주는 클래스.
public class BoardDAO {

    //데이터 베이스에 접근할 수 있도록 도와주는 메소드
    String myid = "system";
    String mypass = "256032";
    String myurl = "jdbc:oracle:thin:@localhost:1521:XE";//접속 url(로컬호스트, 포트151, 오라클 버전)

    Connection con; //데이터 베이스에 접근할 수 있도록 설정
    PreparedStatement pstmt; //데이터 베이스에서 쿼리를 실행시켜주는 객체
    ResultSet rs; //데이터 베이스의 테이블의 결과를 리턴받아 자바에 저장해주는 객체

    public void getCon() {
        try{
            //1.해당 데이터 베이스를 사용 한다고 선언(클래스를 등록 = 오라클을 사용)
            //Class.forName("oracle.jdbc.driver.OracleDriver");//ojdbc안의 패키지(jsp와 dv를연결해준다)
            Class.forName("oracle.jdbc.OracleDriver");//ojdbc안의 패키지(jsp와 dv를연결해준다)
            //2.해당 데이터 베이스에 접속
            con = DriverManager.getConnection(myurl, myid, mypass);
        }
        catch(Exception e) {
            e.printStackTrace();;
        }
    }



    public void deleteBoard(int num) {

        try {
            getCon();

            String sql = "DELETE FROM BOARD WHERE NUM=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, num);
            pstmt.executeUpdate();
            con.close();
        }
        catch(Exception e) {
            e.printStackTrace();
        }
    }

    public void reWriteBoard(BoardBean bean) {
        //부모글 그룹과 글레벨 글스탭 읽기
        int ref = bean.getRef();
        int re_step = bean.getRe_step();
        int re_level = bean.getRe_level();

        try {
            getCon();
            //부모 글보다 큰 re_level의 값을 전부 1씩 증가
            String levelsql = "UPDATE BOARD SET RE_LEVEL=RE_LEVEL+1 WHERE REF=? AND RE_LEVEL > ?";
            pstmt = con.prepareStatement(levelsql);
            pstmt.setInt(1, ref);
            pstmt.setInt(2, re_level);
            pstmt.executeUpdate();
            //답변글 저장
            String sql = "INSERT INTO BOARD VALUES(board_seq.NEXTVAL, ?, ?, ?, ?, sysdate, ?, ?, ?, 0, ?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, bean.getWriter());
            pstmt.setString(2, bean.getEmail());
            pstmt.setString(3, bean.getSubject());
            pstmt.setString(4, bean.getPassword());
            pstmt.setInt(5, ref);
            pstmt.setInt(6, re_step + 1);//답글이기에 부모 글 + 1
            pstmt.setInt(7, re_level + 1);//부모의 re_level + 1을 넣어줌(부모 제외 전부 1 증가시켰으므로)
            pstmt.setString(8, bean.getContent());
            pstmt.executeUpdate();
            con.close();
        }
        catch (Exception e) {
            e.printStackTrace();
        }

    }

    public void updateBoard(BoardBean boardBean) {

        try {
            getCon();
            String sql = "UPDATE BOARD SET SUBJECT=?, REG_DATE=sysdate, CONTENT=?";

            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, boardBean.getSubject());
            pstmt.setString(2, boardBean.getContent());
            pstmt.executeUpdate();
            con.close();
        }
        catch (Exception e) {
            e.printStackTrace();
        }

    }

    public void insertBoard(BoardBean boardBean) {
        int ref = 0; //글 그룹(쿼리를 실행시켜 가장 큰 ref값을 가져운 후 +1)
        int re_step = 1; //자식글 = 부모글
        int re_level = 1;

        try {
            getCon();

            String refsql = "SELECT MAX(ref) FROM BOARD";
            //쿼리 실행 객체
            pstmt = con.prepareStatement(refsql);
            //쿼리 실행 후 결과를 리턴
            rs = pstmt.executeQuery();
            if (rs.next()) {
                ref = rs.getInt(1) + 1;
            }

            //게시글 전체값을 테이블에 저장
            String sql = "INSERT INTO BOARD VALUES (board_seq.NEXTVAL, ?, ?, ?, ?" +
                    ", sysdate, ?, ?, ?, 0, ?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, boardBean.getWriter());
            pstmt.setString(2, boardBean.getEmail());
            pstmt.setString(3, boardBean.getSubject());
            pstmt.setString(4, boardBean.getPassword());
            pstmt.setInt(5, ref);
            pstmt.setInt(6, re_step);
            pstmt.setInt(7, re_level);
            pstmt.setString(8, boardBean.getContent());
            pstmt.executeUpdate();
            con.close();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    public BoardBean getBoardUpdate(int num) {
        BoardBean tmp = new BoardBean();

        try {
            getCon();

            String sql ="SELECT * FROM BOARD WHERE NUM=?";

            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, num);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                tmp.setNum(rs.getInt(1));
                tmp.setWriter(rs.getString(2));
                tmp.setEmail(rs.getString(3));
                tmp.setSubject(rs.getString(4));
                tmp.setPassword(rs.getString(5));
                tmp.setReg_date(rs.getString(6));
                tmp.setRef(rs.getInt(7));
                tmp.setRe_step(rs.getInt(8));
                tmp.setRe_level(rs.getInt(9));
                tmp.setReadCount(rs.getInt(10));
                tmp.setContent(rs.getString(11));
            }

        }
        catch (Exception e) {
            e.printStackTrace();
        }

        return tmp;
    }


    public BoardBean getBoard(int num) {
        BoardBean tmp = new BoardBean();

        try {
            getCon();

            String sql ="SELECT * FROM BOARD WHERE NUM=?";

            String sql2 = "UPDATE BOARD SET readcount = readcount+1 WHERE num=?";
            pstmt = con.prepareStatement(sql2);
            pstmt.setInt(1, num);
            pstmt.executeUpdate();


            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, num);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                tmp.setNum(rs.getInt(1));
                tmp.setWriter(rs.getString(2));
                tmp.setEmail(rs.getString(3));
                tmp.setSubject(rs.getString(4));
                tmp.setPassword(rs.getString(5));
                tmp.setReg_date(rs.getString(6));
                tmp.setRef(rs.getInt(7));
                tmp.setRe_step(rs.getInt(8));
                tmp.setRe_level(rs.getInt(9));
                tmp.setReadCount(rs.getInt(10));
                tmp.setContent(rs.getString(11));
            }

        }
        catch (Exception e) {
            e.printStackTrace();
        }

        return tmp;
    }

    public Vector<BoardBean> getAllBoard() {
        Vector<BoardBean> boardBean = new Vector<>();
        try {
            getCon();

            String sql ="SELECT * FROM BOARD ORDER BY REF DESC, RE_STEP ASC";
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                BoardBean tmp = new BoardBean();
                tmp.setNum(rs.getInt(1));
                tmp.setWriter(rs.getString(2));
                tmp.setEmail(rs.getString(3));
                tmp.setSubject(rs.getString(4));
                tmp.setPassword(rs.getString(5));
                tmp.setReg_date(rs.getString(6));
                tmp.setRef(rs.getInt(7));
                tmp.setRe_step(rs.getInt(8));
                tmp.setRe_level(rs.getInt(9));
                tmp.setReadCount(rs.getInt(10));
                tmp.setContent(rs.getString(11));

                boardBean.add(tmp);
            }

            con.close();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return boardBean;
    }

}
