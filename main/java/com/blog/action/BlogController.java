package com.blog.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/BlogController")
public class BlogController extends HttpServlet {

	private void doProcess(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String RequestURI = request.getRequestURI(); 
		String contextPath = request.getContextPath(); 
		String command = RequestURI.substring(contextPath.length()); 
		
		System.out.println(command +"로 이동중 ..");
		ActionForward forward = null;
		Action action = null;
		
		if(command.equals("/blogList.bl")) {
			forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath("./blog/blogList.jsp");
		}
		
		
		if(forward.isRedirect()) {
			response.sendRedirect(forward.getPath()); //리다이렉트 방식일때
		} else {
			RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
			dispatcher.forward(request, response); //forward방식일때
		}
		
	}
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

}
