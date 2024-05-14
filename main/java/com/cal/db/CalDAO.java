package com.cal.db;

import java.sql.*;

import javax.naming.*;
import javax.sql.DataSource;


import java.util.*;

public class CalDAO {
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	DataSource ds;
	
	public CalDAO() {
		try {
			Context init = new InitialContext();
			ds = (DataSource) init.lookup("java:comp/env/jdbc/MysqlDB");
			
			//con = ds.getConnection();
			System.out.println("DB 연결 성공 !");
		} catch (Exception ex) {
			System.out.println("DB 연결 실패 : " + ex);
			return;
		}
	}

	public int insertData(String cause, double result) {
		String sql = "insert into calculator (cal_op, cal_result) values (? , ?)";
		int rs = 0;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, cause);
			pstmt.setDouble(2, result);
			rs = pstmt.executeUpdate();
			
			System.out.println("DB에 넣기 성공!");
			return rs;
			
		} catch (SQLException e) {
			System.out.println("getBasketList 에러 : " + e);
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (con != null)
				try {
					con.close();
				} catch (SQLException ex) {

				}
		}

		return rs;
		
	}

	public ArrayList<CalBean> getCalList() {
		ArrayList<CalBean> calList = new ArrayList<CalBean>();
		String sql = "select * from calculator order by cal_date DESC;"; //최신순
		CalBean calBean;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				calBean = new CalBean();
				calBean.setCal_no(rs.getInt(1));
				calBean.setCal_date(rs.getDate(2));
				calBean.setCal_op(rs.getString(3));
				calBean.setCal_result(rs.getString(4));
				
				calList.add(calBean);
			}
			
			return calList;
			
		} catch (SQLException e) {
			System.out.println("getBasketList 에러 : " + e);
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (con != null)
				try {
					con.close();
				} catch (SQLException ex) {

				}
			
		}
		
		return calList;
	}
	
	

}
	
