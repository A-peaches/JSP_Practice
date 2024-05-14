package com.cal.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.blog.action.Action;
import com.blog.action.ActionForward;
import com.cal.db.CalDAO;

public class CalResultAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		CalDAO calDAO = new CalDAO();
		ActionForward forward = new ActionForward();
		
		String str = request.getParameter("result"); // 3+6
		double num1 = 0;
		double num2 = 0;
		String operators[] = {"+","-","*","/"};
		String op = "";
		int idx = 0;

		String cause = "";
		double result = 0;
		
		for(int i =0; i < 4; i++ ) {
			if(str.contains(operators[i])) {
				idx = str.indexOf(operators[i]);
				op += operators[i];
				break;
			}
		}

		num1 = Double.parseDouble(str.substring(0, idx));
		num2 = Double.parseDouble(str.substring(idx + 1)); // 연산자 다음 위치부터 숫자만 파싱

		
		System.out.println(num1);
		System.out.println(num2);
		System.out.println(op);
		
		switch(op) {
		case"+" :
			result = num1 + num2;
			break;
		case"-" :
			result = num1 - num2;
			break;
		case"*" :
			result = num1 * num2;
			break;
		case"/" :
			result = num1 / num2;
			break;
		}
		
		cause = num1+" "+op+" "+num2+" = ";
		
		
		calDAO.insertData(cause, result);
		
		request.setAttribute("result",String.valueOf(result));
		
		forward.setRedirect(false);
		forward.setPath("/Calculator.cl");
		
		return forward;
	}

}
