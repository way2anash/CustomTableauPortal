<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
  pageEncoding="ISO-8859-1"%>
<%@ page
  import="java.io.*,java.sql.*,javax.naming.*,javax.sql.*,java.io.*,com.google.common.io.*,tabRest.tabRest"%>
<%@ page import="java.util.ArrayList, com.tableau.oem.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<% 
String username = "";
if (request.getSession(false) != null)
{
  username = (String) session.getAttribute("username");
  username = ((username == null) ? "" : username);
    // -- this will replace a null with a blank
  session.setAttribute("username", username);
}
else
{
  session.setAttribute("username", "");
}
// -- Move this to manufacturing utils
if (username.length() > 0)
{
  // -- Call the helper routine to load Viz thumbmnails
  ManufacturingUtils utils = new ManufacturingUtils();
  utils.loadThumbnails(username, session); 
}
%>

<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js">
<!--<![endif]-->

<head>
<meta charset="utf-8" />
<title>Industrix</title>
<meta name="description" content="" />
<!-- This styles only adds some repairs on devices  -->
<meta name="viewport"
  content="width=device-width, initial-scale=1, maximum-scale=1" />
<!-- Effects for thumbnail images -->
<link rel="stylesheet" href="css/thumbnailImages.css" />
<!-- Favicon -->
<link rel="shortcut icon" href="img/favicon.png" />
<!-- Roboto Condensed Webfont -->
<link href='css/RobotoCondensed.css' rel='stylesheet' type='text/css'>
<!-- Font Awesome CSS -->
<link rel="stylesheet" href="css/font-awesome.min.css" />
<!-- Normalize CSS -->
<link rel="stylesheet" href="css/normalize.css" />
<!-- Owl Carousel CSS -->
<link href="css/owl.carousel.css" rel="stylesheet" media="screen">
<!-- REVOLUTION BANNER CSS SETTINGS -->
<link rel="stylesheet" type="text/css" href="rs-plugin/css/settings.css"
  media="screen" />
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="css/bootstrap.min.css" />
<link rel="stylesheet" href="css/offcanvas.css" />
<!-- Main CSS -->
<link rel="stylesheet" href="style.css" />
<!-- Responsive Framework -->
<link href="css/responsive.css" rel="stylesheet" media="screen" />
<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
		<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
		<script src="js/respond.min.js"></script>
		<![endif]-->
<script src="./js/jquery-1.7.2.min.js"></script>
</head>

<body>
  <div class="wrapper">
    <div class="row row-offcanvas row-offcanvas-left">
      <!--[if lt IE 7]>
					<p class="browsehappy">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
				<![endif]-->
      <div class="inner-wrapper">     
        <!-- logo and social media -->
        <%@include file="include/logo-social-media-row.html" %>
        <!-- Common navigation page -->
        <jsp:include page="include/navigation.jsp" />
        <section class="contact-page-area">
          <div class="container">
            <div class="row">
              <div class="col-md-12">
                <div
                  class="contact-input-form box-wrapper mt-15 sm-mrgright-15 xs-mrgright-15">
                  <div class="contact" id="analytics_div">
                    <dl class="contact-address dl-horizontal"></dl>
                    <h2 align="center">Your Personalized Analytics Menu</h2>
                    <c:if test="${(sessionScope.username eq '')}" >
                      <br />
                      You must be logged in to access your Analytics. Click 
                      <a href=./login.jsp>here</a> to log in now.
                    </c:if>                   
                  </div>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-md-9 less-pad-right">                   
                <br />                                       
                <c:if test="${not (sessionScope.username eq '')}" >                  
                  <br />
                  
                  
                  <!-- Loop through, display thumbnails -->
                  <c:forEach items="${tableauViews}" var="view">
                    <div class="col-md-4 col-sm-6">
                      <div class="portfolio-item">
                        <div class="portfolio-image">
                          <a href="embedding.jsp?workbook=${view.workbookContextName}&view=${view.viewContextName}">
                            <img src="./img/vizThumbnails/${view.viewId}.png" alt="${view.viewContextName}">
                          </a>
                        </div>           
                        <div class="portfolio-info-fade">
                          <ul>    
                            <li class="portfolio-project-name">${view.viewName}</li>                        
                            <li class="read-more">
                              <a href="embedding.jsp?workbook=${view.workbookContextName}&view=${view.viewContextName}" class="btn">Open</a>
                            </li>
                          </ul>
                        </div>
                      </div>
                    </div>                                                                              
                  </c:forEach>
                  
                  
                </c:if>   
              </div> <!-- div class="col-md-9 less-pad-right" -->
            </div> <!--  row -->
          </div>
        </section>
        <!-- being footer -->
        <jsp:include page="include/footer.jsp" />
        <!-- end footer -->
      </div>
    </div>
  </div>

  <!--Start script-->
  <script src="js/jquery.min.js"></script>
  <script src="js/modernizr-2.6.2.min.js"></script>
  <script src="js/jquery.validate.js"></script>
  <!-- jQuery REVOLUTION Slider  -->
  <script type="text/javascript"
    src="rs-plugin/js/jquery.themepunch.plugins.min.js"></script>
  <script type="text/javascript"
    src="rs-plugin/js/jquery.themepunch.revolution.min.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <script src="js/owl.carousel.min.js"></script>
  <script src="js/jquery.scrollUp.js"></script>
  <script src="js/offcanvas.js"></script>
  <script src="js/jquery.prettyPhoto.js"></script>
  <script src="js/script.js"></script>
  <script src="js/contactform.js"></script>
  <!--End script-->

</body>

</html>