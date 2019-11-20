package com.tableau.oem;

import tabRest.tabRest;
import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.DocumentBuilder;

import org.w3c.dom.Document;
import org.w3c.dom.NodeList;

import com.google.common.io.ByteStreams;

import org.w3c.dom.Node;
import org.w3c.dom.Element;
import java.io.InputStream;

public class ManufacturingUtils implements ServletContextListener {

	private static ServletContext ctx = null;

	public static String TABLEAU_IMPERSONATION_USER;
	public static String TABLEAU_IMPERSONATION_PASSWORD;

	public static String SERVER_URL;
	public static String SITE;
	public static String TABLEAU_SERVER_HOST;
	public static String TABLEAU_SERVER_PORT;
	public static String TABLEAU_API_VERSION;
	public static String PRODUCTION_WEB_SERVER;
	public static String VIZ_THUMBNAILS_FOLDER;
	public static String WEB_INF_FOLDER;
	
	public void loadThumbnails(String username, HttpSession session) {

		// -- we'll hold on to some of the details of the workbooks and views
		ArrayList<TableauView> tableauViews = new ArrayList<TableauView>();

		// -- use DataPainters.com library to simplify REST API access
		// TIP: You can a C# library as well at DataPainters.com
		// TIP: For an outstanding Python library, see 
		//      https://tableauandbehold.com/2017/07/31/tableau_tools-4-0-0-is-released/
		tabRest tab1 = getDataPaintersRestHelper();

		// -- Basic recipe for creating a dynamic UI for your users
		//
		//    1) Use client library - it will get the REST API token, make all the necessary calls,
		//       and return exactly what you want
		//    2) For a dynamic UI, first retrieve workbooks user is permissioned to see, e.g. tsGetWorkbooksByUser
		//    3) For each workbook, retrieve the views
		//    4) For each view, retrieve the Viz thumbnail. Yes, the client library will fetch yout the
		//       binary data for those as well
		//    5) Write the thumbnails to disk (can choose to refresh only hourly, daily, etc).
		//    6) Integrate the thumbnails and corresponding Viz URLs into your client page		
		
		try {

			// -- Note we can retrieve only the workbooks logged in user has access to
			String[] workbooks = tab1.tsGetWorkbooksByUser(username);

			for (String workbook : workbooks) {

				if (workbook == null) 
					continue;

				String[] wkbkDetails = workbook.split(",");
				String wkbkId = wkbkDetails[0];
				String wkbkContextPath = wkbkDetails[2];
				String wkbkContextName = wkbkContextPath.substring(wkbkContextPath.lastIndexOf("/") + 1);

				// -- get thumbnail for each view in workbook
				String views[] = tab1.tsGetViewsFromWorkbook(wkbkId);

				for (String view : views) {
					
					if (view == null) 
						continue;

					// -- get view details
					String[] vwDetails = view.split(",");

					// -- again, use library to abstract away details of retrieving
					String vwId = vwDetails[0];
					InputStream icon = tab1.tsGetWorkbookViewIcon(wkbkId, vwId);
					
					// -- write thumbnail to disk
					File f = new File(VIZ_THUMBNAILS_FOLDER + "/" + vwId + ".png");
					ByteStreams.copy(icon, new FileOutputStream(f));

					// -- populate our tableau view value object
					TableauView tableauView = new TableauView();

					String vwContextPath = vwDetails[2];
					String vwContextName = vwContextPath.substring(vwContextPath.lastIndexOf("/") + 1);

					tableauView.setWorkbookContextName(wkbkContextName);
					tableauView.setViewId(vwId);
					tableauView.setViewContextName(vwContextName);
					tableauView.setViewName(vwDetails[1]);

					tableauViews.add(tableauView);

				} // -- for (String view: views)

			} // -- for (String workbook : workbooks)

		} catch (Exception e) {
			
			e.printStackTrace();
		}

		// -- make the information we collected available to embedded jsp
		session.setAttribute("tableauViews", tableauViews);

	}
	
	// -- By way of example, we'll do this the "old-fashioned" way
	//    job can be made much easier using client helper library	
	//    TIP: You can avoid having to write all this code by using a client-library!
	//         See "loadThumbnails" above
	public String getTrustedTicket(String server, String target_site, String username) {

		// -- Basic recipe for creating a dynamic UI for your users
		//
		//    1) Configure Tableau Server to trust the host(s) that will be requesting trusted tickets
		//       https://onlinehelp.tableau.com/current/server/en-us/trusted_auth_trustIP.htm
		//    2) Trusted tickets are typically requested via server-side code and inserted into
		//       the URL of the Viz requested by the portal user user, for example
		//       http(s)://<tableau server>/trusted/<trusted ticket>/t/<site>/views/<workbook>/<view>?embed:=y";	
		StringBuffer response = new StringBuffer("");
		try {

			URL url = new URL(server + "/trusted");
			HttpURLConnection req = (HttpURLConnection) url.openConnection();
			req.setRequestMethod("POST");

			String urlParameters = "server=" + URLEncoder.encode(server, "UTF-8") + "&username=" + username
					+ "&target_site=" + target_site;
			byte[] postData = urlParameters.getBytes(StandardCharsets.UTF_8);
			int postDataLength = postData.length;

			// TIP: Setting the content type correctly is very important
			req.setRequestProperty("Content-Length", Integer.toString(postDataLength));
			req.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			req.setRequestProperty("charset", "UTF-8");

			req.setUseCaches(false);
			req.setDoOutput(true);

			DataOutputStream wr = new DataOutputStream(req.getOutputStream());
			wr.write(postData);

			int responseCode = req.getResponseCode();

			if (responseCode == 200) {
				BufferedReader in = new BufferedReader(new InputStreamReader(req.getInputStream()));
				String inputLine;

				while ((inputLine = in.readLine()) != null) {
					response.append(inputLine);
				}
				in.close();
			} else {
				return "";
			}

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		return response.toString();
	}

	
	// -- Demonstrate using pure Java to get REST API token
	//    TIP: Again, this is greatly simplified by using a client library! 
	//         See "loadThumbnails" above
	public String getRESTApiToken() {

		String retval = "";

		// - go with simple XML string
		String request = "<tsRequest>" + "    <credentials name=\"" + TABLEAU_IMPERSONATION_USER + "\" "
				+ "    password=\"" + TABLEAU_IMPERSONATION_PASSWORD + "\" >" + "    <site contentUrl=\""
				+ SITE + "\" />" + "    </credentials>" + "</tsRequest>";

		StringBuffer response = new StringBuffer("");

		try {

			URL url = new URL(
					ManufacturingUtils.SERVER_URL + "/api/" + ManufacturingUtils.TABLEAU_API_VERSION + "/auth/signin");
			HttpURLConnection req = (HttpURLConnection) url.openConnection();
			req.setRequestMethod("POST");

			byte[] postData = request.getBytes(StandardCharsets.UTF_8);
			int postDataLength = postData.length;

			req.setRequestProperty("Content-Length", Integer.toString(postDataLength));
			// TIP: Setting the content type correctly is very important
			req.setRequestProperty("Content-Type", "text/xml");

			req.setUseCaches(false);
			req.setDoOutput(true);

			DataOutputStream wr = new DataOutputStream(req.getOutputStream());
			wr.write(postData);

			int responseCode = req.getResponseCode();

			if (responseCode == 200) {
				BufferedReader in = new BufferedReader(new InputStreamReader(req.getInputStream()));
				String inputLine;

				while ((inputLine = in.readLine()) != null) {
					response.append(inputLine);
				}
				in.close();
			}

		} catch (Exception e) {
			System.out.println("Error getting REST API token: " + e.getMessage());

		}

		// -- Process response XML
		String xml = response.toString();
		try {

			DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
			InputStream is = new ByteArrayInputStream(xml.getBytes(StandardCharsets.UTF_8));
			Document doc = dBuilder.parse(is);

			doc.getDocumentElement().normalize();
			NodeList nList = doc.getElementsByTagName("credentials");
			Node node = nList.item(0);
			if (node.getNodeType() == Node.ELEMENT_NODE) {
				Element el = (Element) node;
				retval = el.getAttribute("token");
			}

		} catch (Exception e) {
			System.out.println("Err getting apiToken: " + e.toString());
		}

		return retval;
	}

	// -- this would typically be a call to a database, or, a 3rd-party
	//    Web SSO product might be used, etc.
	public String authenticateUser(String username, String password) {

		String result = null;
		
		File users = new File(WEB_INF_FOLDER + "\\db\\users.txt");
		BufferedReader b = null;
		try {
			b = new BufferedReader(new FileReader(users));
			
            String readLine = "";

            while ((readLine = b.readLine()) != null) {
            	if (readLine.equalsIgnoreCase(username))
            	{
            		result = username;
            		break;
            	}
            }
		}
		catch (FileNotFoundException fnfe)
		{
			System.out.println("Not able to find users.txt database file.");
		}
		catch (IOException ioe)
		{
			System.out.println("Unable to read from users.txt database file.");
		}
		finally
		{
			try {
				b.close();
			}
			catch (IOException ioe) 
			{
				System.out.println("Error trying to close users.txt database file.");
			}
		}
			
		return result;

	}

	// -- used in navigation.jsp to make it possible to encapsulate a lot of common content
	//    in a single page
	public String getPageName(HttpServletRequest request) {

		// -- page-level Java

		String requestURL = request.getRequestURL().toString();

		// -- assume all pages that include this page are JSPs
		int indexOfJsp = requestURL.toUpperCase().lastIndexOf(".JSP");
		String pageName = "index.jsp";

		if (indexOfJsp > 0) {
			String chunk = requestURL.substring(0, indexOfJsp);
			pageName = chunk.substring(chunk.lastIndexOf("/") + 1).toUpperCase();

		}

		return pageName;

	}

	// -- capture contents of context and store in static vars	
	@Override
	public void contextInitialized(ServletContextEvent sce) {

		ctx = sce.getServletContext();

		// -- capture vars
		TABLEAU_IMPERSONATION_USER = ctx.getInitParameter("TableauImpersonationUser");
		TABLEAU_IMPERSONATION_PASSWORD = ctx.getInitParameter("TableauImpersonationPassword");

		SERVER_URL = ctx.getInitParameter("TableauServerUrl");
		SITE = ctx.getInitParameter("TableauSite");
		TABLEAU_SERVER_HOST = ctx.getInitParameter("TableauServerHost");
		TABLEAU_SERVER_PORT = ctx.getInitParameter("TableauServerPort");
		TABLEAU_API_VERSION = ctx.getInitParameter("TableauApiVersion");
		PRODUCTION_WEB_SERVER = ctx.getInitParameter("ProductionWebServer");
		VIZ_THUMBNAILS_FOLDER = ctx.getRealPath(File.separator) + "/img/vizThumbnails";
		WEB_INF_FOLDER = ctx.getRealPath("/WEB-INF");

	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
	}

	public String getContextParam(String paramKey) {
		return ctx.getInitParameter(paramKey);
	}

	// TIP: Where to get Python, Java and C# libraries is shown above the "loadThumbnails"
	//      function above
	public tabRest getDataPaintersRestHelper() {
		tabRest tab = new tabRest(SERVER_URL, TABLEAU_IMPERSONATION_USER, TABLEAU_IMPERSONATION_PASSWORD, SITE);
		return tab;
	}

}
