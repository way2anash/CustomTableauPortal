<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="com.tableau.oem.*" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% 
// -- Java code to support tags
ManufacturingUtils utils = new ManufacturingUtils();
pageContext.setAttribute("pageName", utils.getPageName(request));
%>

        <c:choose>
          <c:when test="${pageScope.pageName eq 'SERVICES'}">
            <div class="container mt-20">
          </c:when>
          <c:when test="${pageScope.pageName eq 'SINGLE'}">
            <div class="container mt-15">
          </c:when>       
          <c:when test="${pageScope.pageName eq 'ANALYTICS'}">
            <div class="container mt-15">
          </c:when>    
          <c:when test="${pageScope.pageName eq 'LOGIN'}">
            <div class="container mt-15">
          </c:when>   
          <c:when test="${pageScope.pageName eq 'EMBEDDING'}">
            <div class="container mt-15">
          </c:when>               
          <c:otherwise>
            <div class="container">
          </c:otherwise>
         </c:choose>

          <!-- make dynamic --> 
          <!--<div class="container">-->         
            <div class="footer-widget box-wrapper ">
              <div class="row">           
                <div class="col-lg-3 col-md-2 col-sm-4 col-xs-12">
                  <div class="custom-menu-widget">
                    <h2 class="widget-title "><span><i class="fa fa-twitter"></i> Latest Tweets</span></h2>
                    <p>Check out this great hashtag  <a target="_self" href="#">#data17</a> and be sure to visit the TC17 site   <a target="_self" href="#">http://tc17.tableau.com</a></p>
                  </div>            
                </div>            
                <div class=" col-lg-2 col-md-2 col-sm-4 col-xs-12">
                  <div class="custom-menu-widget">
                    <h2 class="widget-title "><span><i class="fa fa-briefcase "></i> Industrix</span></h2>
                    <div class="custom-widget">
                      <ul>
                        <li><a href="#" title="About Us">About Us</a></li>
                        <li><a href="#" title="">New Services</a></li>
                        <li><a href="#" title="">Recent Projects</a></li>
                        <li><a href="#" title="">Contacts</a></li>
                        <li><a href="#" title="">Blog</a></li>
                      </ul>
                    </div>
                  </div>
                </div>
                <div class=" col-lg-2 col-md-2 col-sm-4 col-xs-12">
                  <div class="custom-menu-widget">
                    <h2 class="widget-title "><span><i class="fa fa-cloud "></i> Information</span></h2>
                    <div class="custom-widget">
                      <ul>
                        <li><a href="#" title="About Us">Presss</a></li>
                        <li><a href="#" title="">Terms</a></li>
                        <li><a href="#" title="">Clients</a></li>
                        <li><a href="#" title="">Partners</a></li>
                        <li><a href="#" title="">Support</a></li>
                      </ul>
                    </div>
                  </div>
                </div>
                <div class=" col-lg-3 col-md-3 col-sm-6 col-xs-12">
                  <div class="custom-menu-widget">
                    <h2 class="widget-title "><span><i class="fa fa-clock-o "></i> Office Hours</span></h2>
                    <div class="custom-widget">
                      <p>Our support Hotline is available 8 Hours a day</p>
                      <p><strong>Monday-Friday:</strong> 10am to 8pm<br>
                      <strong>Saturday and Sunday:</strong> By Special Appointment<br>
                      <strong>Weekend:</strong> Closed</p>
                    </div>
                  </div>
                </div>
                <div class=" col-lg-2 col-md-3 col-sm-6 col-xs-12">
                  <div class="custom-menu-widget">
                    <h2 class="widget-title "><span><i class="fa fa-map-marker "></i> Location Map</span></h2>
                    <div class="map">
                      <img src="img/worldmap.png" alt="worldmap" />
                    </div>
                  </div>
                </div>
              </div> <!-- //row -->
            </div>  <!-- //footer-widget -->
            <div class="copyright-text box-wrapper">
              <div class="row">
                <div class="col-md-6 col-sm-6">
                  <div class="left-copy-text">
                    <p>Copyright &#169; 2014 Industrix. All Rights
                    Reserved. <br /> <a href="#" title="" ></a></p>
                  </div> <!-- //left-copy-text -->
                </div> <!-- //col-md-6 -->
                <div class="col-md-6 col-sm-6 hidden-xs">
                  <div class="footer-right">
                    <div class="social-icon pull-right social-fix">
                      <ul>
                        <li><a href="#" title="RSS" target="_blank"><i class="fa fa-rss"></i></a></li>
                        <li><a href="#" title="Facebook" target="_blank"><i class="fa fa-facebook"> </i></a></li>
                        <li><a href="#" title="Twitter" target="_blank"><i class="fa fa-twitter"></i></a></li>
                        <li><a href="#" title="Google plus" target="_blank"><i class="fa fa-google-plus"></i></a></li>
                        <li><a href="#" title="YouTube" target="_blank"><i class="fa fa-youtube"></i></a></li>
                        <li><a href="#" title="Linkedin" target="_blank"><i class="fa fa-linkedin"></i></a></li>
                        <li><a href="#" title="Flickr" target="_blank"><i class="fa fa-flickr"></i></a></li>
                        <li><a href="skype:#?call" title="Skype" target="_blank"><i class="fa fa-skype"></i></a></li>
                        <li><a href="" title="Vimeo" target="_blank"><i class="fa fa-vimeo-square"></i></a></li>
                      </ul>
                    </div> <!-- //social-icon -->
                  </div> <!-- //footer-right -->
                </div> <!-- //col-md-6 -->
              </div> <!-- //row -->
            </div> <!-- //copyright-text -->
          </div> <!-- //container -->