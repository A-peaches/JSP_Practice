package com.cal.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.blog.action.Action;
import com.blog.action.ActionForward;
import com.cal.db.CalBean;
import com.cal.db.CalDAO;

public class CalListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		CalDAO calDAO = new CalDAO();
		ArrayList<CalBean> calList = new ArrayList<CalBean>();
		
		calList = calDAO.getCalList();
		
		if(calList == null) {
			System.out.println("계산 기록 불러오기 실패 ! ");
			return null;
		}
		
		request.setAttribute("calList", calList);
		
		forward.setRedirect(false);
		forward.setPath("./calculator/calList.jsp");
		
			
		return forward;
	}

}
