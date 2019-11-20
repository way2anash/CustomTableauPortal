package com.tableau.oem;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import com.google.common.io.ByteStreams;
import tabRest.tabRest;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class AjaxController
 */
@WebServlet("/ManufacturingServlet")
public class ManufacturingServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	
	ServletContext servletContext;
	ServletConfig servletConfig;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ManufacturingServlet() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		servletContext = this.getServletContext();
        
		ManufacturingUtils utils = new ManufacturingUtils();
		HttpSession session = request.getSession();

		// -- who called and what are we doing?
		String referrer = request.getParameter("referringPage");
		referrer = ((referrer == null) ? "" : referrer).toUpperCase();

		String pageAction = request.getParameter("pageAction");
		pageAction = ((pageAction == null) ? "" : pageAction).toUpperCase();

		if (referrer.equals("LOGIN")) {

			if (pageAction.equals("LOGIN")) {
			
				String username = request.getParameter("username");
				String password = request.getParameter("password");

				// -- they're required fields and shouldn't be null
				password = ((password == null) ? "" : password);
				username = ((username == null) ? "" : username);
				
				session.setAttribute("loginErrorMessage", "");
				
				String authenticatedUsername = utils.authenticateUser(username, password);
				if (authenticatedUsername != null) 
				{
					
					session.setAttribute("username", authenticatedUsername);
					response.sendRedirect("analytics.jsp");
				
				} 
				else // -- if (authenticatedUsername != null)
				{
				
					session.setAttribute("loginErrorMessage", 
							"We were unable to authenticate you using the credentials you provided. " + 
							"Please try again.");
					session.setAttribute("username", "");
					response.sendRedirect("login.jsp");
				
				}
				
			} 
			else if (pageAction.equals("LOGOUT")) 
			{
				
				session.setAttribute("username", "");
				response.sendRedirect("login.jsp");
			
			} // -- if (pageAction.equals("LOGIN"))
		
		} // -- if (referrer.equals("LOGIN"))
		else
		{
			response.sendRedirect("index.jsp");
		}
		
	} // -- protected void doPost
	
}
