package com.cal.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.blog.action.Action;
import com.blog.action.ActionForward;

/**
 * Servlet implementation class CalActionController
 */
@WebServlet("/CalActionController")
public class CalController extends HttpServlet {
	
	private void doProcess(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String RequestURI = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = RequestURI.substring(contextPath.length());

		System.out.println(command + "로 이동중 ..");
		ActionForward forward = null;
		Action action = null;

		if (command.equals("/Calculator.cl")) {
			forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath("./calculator/calculator.jsp");
		}else if (command.equals("/CalResult.cl")) {
			action = new CalResultAction();
			try {
				forward = action.execute(request, response);
			}catch(Exception e) {
				e.printStackTrace();
			} 
		} else if (command.equals("/CalList.cl")) {
			action = new CalListAction();
			try {
				forward = action.execute(request, response);
			}catch(Exception e) {
				e.printStackTrace();
			} 
		}

		if (forward.isRedirect()) {
			response.sendRedirect(forward.getPath()); // 리다이렉트 방식일때
		} else {
			RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
			dispatcher.forward(request, response); // forward방식일때
		}

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doProcess(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doProcess(request, response);
	}
}
