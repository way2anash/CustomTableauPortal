<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page import="com.tableau.oem.*"%>

<%
	// -- Java code to support tags
	ManufacturingUtils utils = new ManufacturingUtils();
	pageContext.setAttribute("pageName", utils.getPageName(request));
%>

<!-- Navigation Area -->
<div class="mainnav-wrapper">

  <div class="container">
    <div class="navbar navbar-default mainnav">

      <!-- NAVBAR HEADER -->
      <div class="navbar-header">
        <button type="button" class="navbar-toggle"
          data-toggle="offcanvas" data-target="#myNavmenu"
          data-canvas="#myNavmenuCanvas" data-placement="left">
          <i class="fa fa-bars"></i>
        </button>

        <!-- HEAD SEARCH -->
        <div class="head-search">
          <form method="post" action="" class="form-search">
            <div class="search">
              <i class="fa fa-search"></i><input type="text" size="20"
                class="form-control " maxlength="20" name="searchword">
            </div>
          </form>
        </div>

      </div>

      <!-- NAVBAR MAIN -->
      <nav class="navbar-collapse collapse">
        <ul class="nav navbar-nav">

          <c:choose>
            <c:when test="${pageScope.pageName eq 'INDEX'}">
              <li class="active">
            </c:when>
            <c:otherwise>
              <li>
            </c:otherwise>
          </c:choose>

          <a href="index.jsp">Home</a>
          </li>

          <c:choose>
            <c:when test="${pageScope.pageName eq 'SERVICES'}">
              <li class="active">
            </c:when>
            <c:otherwise>
              <li>
            </c:otherwise>
          </c:choose>

          <a href="services.jsp">Services</a>
          </li>

          <c:choose>
            <c:when test="${pageScope.pageName eq 'SINGLE'}">
              <li class="active">
            </c:when>
            <c:otherwise>
              <li>
            </c:otherwise>
          </c:choose>


          <a href="single.jsp">Blog</a>
          </li>

          <c:choose>
            <c:when test="${pageScope.pageName eq 'ANALYTICS'}">
              <li class="active">
            </c:when>
            <c:otherwise>
              <li>
            </c:otherwise>
          </c:choose>

          <a href="analytics.jsp">Self-service Analytics</a>
          </li>


          <c:choose>
            <c:when test="${pageScope.pageName eq 'LOGIN'}">
              <li class="active">
            </c:when>
            <c:otherwise>
              <li>
            </c:otherwise>
          </c:choose>

          <a href="login.jsp"> <c:choose>
              <c:when test="${sessionScope.username eq ''}">                                        
                            Login
                            </c:when>
              <c:otherwise>
                            Logout
                            </c:otherwise>
            </c:choose>

          </a>

          </li>

          <li class="dropdown mega-fw has-megamenu"><a href="#"
            data-toggle="dropdown" class="dropdown-toggle">Contact<b
              class="caret"></b></a>
            <div
              class="submenu-wrapper submenu-wrapper-topbottom megamenu-wrapper">
              <div
                class="submenu-inner  submenu-inner-topbottom megamenu-inner">
                <ul class="dropdown-menu">
                  <li>
                    <div class="mega-content">
                      <div class="row">
                        <!-- mega menu item -->
                        <div class="col-sm-3">
                          <div class="mega-menu-item">
                            <h2>Our location</h2>
                            <p>
                              350 Fifth Avenue 34th floor <br> New
                              York NY 10065 USA
                            </p>
                            <img class="img-responsive"
                              src="img/menu-map.jpg" alt="Demo Image" />
                          </div>
                        </div>
                        <!-- mega menu item -->
                        <div class="col-sm-3">
                          <div class="mega-menu-item">
                            <h2>Head Office</h2>
                            <div class="mega-item-text">
                              <p>
                                <strong>Email</strong><br>Please
                                feel free to send us an email <br>
                                <a class="email" href="#">info@tableau.com</a>
                              </p>
                              <p>
                                <strong>Phone</strong><br> Give us
                                a call<br> +1-212-736-1234
                              </p>
                              <p>
                                <strong>Mobile</strong><br> Buy
                                Online or call <br> +1-212-736-1234
                              </p>
                            </div>
                          </div>
                        </div>
                        <!-- mega menu item -->
                        <div class="col-sm-3">
                          <div class="mega-menu-item">
                            <h2>Facetory Address</h2>
                            <div class="mega-item-text">
                              <p>
                                <strong>Steel Mile</strong><br>261-3502
                                Natoque Street<br>Glen CoveQC<br>Liberia
                              </p>
                              <p>
                                <b>Petroleum</b><br>4027 Rutrum <br>Ave
                                Gulfport<br>NBSlovakia
                              </p>
                              <p>
                                <strong>Bio </strong><b>Diesel</b><br>446-8604
                                Risus Avenue Quincy<br>Nova Scotia<br>Colombia
                              </p>
                            </div>
                          </div>
                        </div>
                        <!-- mega menu item -->
                        <div class="col-sm-3">
                          <div class="mega-menu-item">
                            <h2>this is sample text</h2>
                            <div class="mega-item-text">
                              <p>Our support Hotline is available 8
                                Hours a day</p>
                              <p>
                                <strong>Monday-Friday: </strong> 10am to
                                8pm <br> <strong>Saturday
                                  and Sunday:</strong> By Special Appointment <br>
                                <strong>Weekend:</strong> Closed
                              </p>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </li>
                </ul>
              </div>
            </div> <!-- /megamenu-wrapper --></li>
          <!-- contact -->

          <c:choose>
            <c:when test="${pageScope.pageName eq 'ABOUT'}">
              <li class="active">
            </c:when>
            <c:otherwise>
              <li>
            </c:otherwise>
          </c:choose>

          <a href="about.jsp">About Us</a>
          </li>

        </ul>
      </nav>
    </div>
  </div>
</div>
