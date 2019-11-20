<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.sql.*,javax.naming.*,javax.sql.*"%>
<%@ page import="com.tableau.oem.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String username = "";
	if (request.getSession(false) != null) {
		username = (String) session.getAttribute("username");
		username = ((username == null) ? "" : username);
		// -- this will replace a null with a blank
		session.setAttribute("username", username);

	} else {
		session.setAttribute("username", "");
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
<!-- This styles only adds some repairs on idevices  -->
<meta name="viewport"
  content="width=device-width, initial-scale=1, maximum-scale=1" />
<!-- Favicon -->
<link rel="shortcut icon" href="img/favicon.png" />
<!-- Roboto Condensed Webfont -->
<link
  href='css/RobotoCondensed.css'
  rel='stylesheet' type='text/css'>
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
        <%@include file="include/logo-social-media-row.html"%>
        <!-- Common navigation page -->
        <jsp:include page="include/navigation.jsp" />
        <!-- primary content area -->
        <section class="contact-page-area">
          <div class="container">
            <div class="row" style="height: 240px;"">
              <div class="col-md-9 less-pad-right"">
                <div
                  class="contact-input-form box-wrapper mt-15 sm-mrgright-15 xs-mrgright-15">
                  <c:if test="${sessionScope.username eq ''}">
                    <div class="contact" id="login_div"
                      style="height:240px;>
                      <dl class="contact-address dl-horizontal"></dl>
                      <h2>Login</h2>
                      <div class="contact-form" id="contact-form-div" name="contact-form-div">                     
                        <form id="loginForm" name="loginForm" action="./ManufacturingServlet"
                          class="form-validate" method="post">                        
                          <fieldset>
                            <p class="required-field">All fields with an * are required.</p>
                            <div class="control-group col-md-12">
                              <div class="row">
                                <div
                                  class="control-contact col-md-6 col-xs-12">
                                  <div class="contact-label">
                                    <label class="required">
                                      Username<span class="star">&nbsp;*</span>
                                    </label> <input id="username" name="username"
                                      required="" size="30" type="text"
                                      value="" />
                                  </div>
                                </div>
                                <div
                                  class="control-contact col-md-6 col-xs-12">
                                  <div class="contact-label">
                                    <label class="required">
                                      Password<span class="star">&nbsp;*</span>
                                    </label> <input id="password" name="password"
                                      value="" size="30"
                                      required="password" type="password" />
                                  </div>
                                </div>
                                <input type="hidden" name="referringPage"
                                  value="login" /> <input type="hidden"
                                  name="pageAction" value="login" />
                                  <c:if test="${not (sessionScope.loginErrorMessage eq '')}"> 
                                    <div class="control-contact col-md-12 col-xs-12">   
                                      <c:out value="${sessionScope.loginErrorMessage}" />
                                      <c:set var="loginErrorMessage" scope="session" value="${''}"/>
                                      <c:set var="loginErrorMessage" scope="page" value="${''}" />
                                    </div> 
                                    <br />
                                  </c:if>                                  
                              </div> <!-- row -->
                            </div>
                            <div class="contact-form-submit">
                              <button
                                class="btn btn-primary validate subbtn"
                                id="btnLogin" type="submit">Submit</button>
                            </div>
                          </fieldset>
                        </form>
                      </div>
                    </div>                  
                  </c:if>
                  
                  <c:if test="${not(sessionScope.username eq '')}"> 
                    <div class="contact" id="logout_div" style="height:220px;">
                      <dl class="contact-address dl-horizontal"></dl>
                      <h2>Logout</h2>
                      <div class="contact-form" id="logout-form-div"
                        name="contact-form-div">                     
                        <form id="logoutForm" name="logoutForm" action="ManufacturingServlet"
                          class="form-validate" method="post"> 
                          <fieldset>
                            <p class="required-field">Simply click the
                              button below to confirm that you want to log out.</p>
                            <div class="logout-form-submit">
                              <button
                                class="btn btn-primary validate subbtn"
                                id="btnLogout" type="submit">Logout</button>
                            </div>
                            <input type="hidden" name="referringPage"
                              value="login" /> <input type="hidden"
                              name="pageAction" value="logout" />
                          </fieldset>
                        </form>
                      </div>
                    </div>
                  </c:if> 
                </div>
              </div>
              <div class="col-md-3" >
                <div class="contact-page-sidebar box-wrapper mt-15 ">
                <div style="height:240px;">    
                  <h3 class="sidebar-title">
                    <span>Address</span>
                  </h3>
                  <p>
                    <strong>Email</strong><br> Please feel free to
                    send us an email info@tableau.com
                  </p>
                  <p>
                    <strong>Phone</strong><br> Give us a call at
                    +1-212-736-1234
                  </p>
                  <p>
                    <strong>Location</strong><br> 350 Fifth Avenue,
                    34th floor New York NY 10065 USA
                  </p>
                </div>
                </div>
              </div>
            </div>
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
  <!--End script "" -->

</body>

</html>