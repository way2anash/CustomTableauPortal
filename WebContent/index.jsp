<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
  pageEncoding="ISO-8859-1"%>
<%@ page
  import="java.io.*,java.sql.*,javax.naming.*,javax.sql.*,com.tableau.oem.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String username = "";
	if (request.getSession(false) != null) {
		username = (String) session.getAttribute("username");
		username = ((username == null) ? "" : username);
		// -- this will replace a null with a blank
		session.setAttribute("username", username);
		int foo = 1;
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

<!-- note opening html tag above -->
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
</head>

<body>

  <!-- standard initial tags -->
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
        <!-- Slider Area -->
        <div class="container">
          <div class="box-shadow-area showcase mt-20">
            <div class="row">
              <div class="col-md-7 col-sm-12 col-xs-12">
                <div class="showcase-left">
                  <div class="tp-banner-container">
                    <div class="tp-banner">
                      <ul>
                        <!-- SLIDE  -->
                        <li data-transition="fade" data-slotamount="7"
                          data-masterspeed="1500">
                          <!-- MAIN IMAGE --> <!-- <img src="img/slide-a2.jpg" -->
                          <img src="img/slide-a1.png" alt="slidebg1"
                          data-bgfit="cover" data-bgposition="left top"
                          data-bgrepeat="no-repeat"> <!-- LAYERS -->
                          <!-- LAYER NR. 1 -->
                          <div
                            class="tp-caption slider-caption skewfromrightshort fadeout"
                            data-x="10" data-y="170" data-speed="500"
                            data-start="1200"
                            data-easing="Power4.easeOut">
                            We Are Professional, <br /> Competitive And
                            <br />Competent In Our<br /> Service
                          </div>
                        </li>
                        <!-- SLIDE  -->
                        <li data-transition="zoomout"
                          data-slotamount="7" data-masterspeed="1000">
                          <!-- MAIN IMAGE --> <!-- <img src="img/slide-a2.jpg" -->
                          <img src="img/slide-a2.png" alt="darkblurbg"
                          data-bgfit="cover" data-bgposition="left top"
                          data-bgrepeat="no-repeat"> <!-- LAYERS -->
                          <!-- LAYER NR. 1 -->
                          <div
                            class="tp-caption slider-caption2 skewfromrightshort fadeout"
                            data-x="50" data-y="180" data-speed="500"
                            data-start="1200"
                            data-easing="Power4.easeOut">
                            We Have a Team Of Leaders And <br />
                            Professionalsn That Know Their <br /> Job
                            And Do It Well
                          </div>
                        </li>
                      </ul>
                    </div>
                  </div>
                </div>
                <!-- //showcase-left -->
              </div>
              <!-- //col-md-7 -->

              <div class="col-md-5 col-sm-12 col-xs-12">
                <div class="showcase-right">
                  <ul class="top-service-box">
                    <li>
                      <h2>Oil &amp; Gas</h2>
                      <p>Li Europan lingues es membres del sam
                        familie.</p> <a href="#">DETAILS</a>
                    </li>
                    <li>
                      <h2>Utilities</h2>
                      <p>Lor separat existentie es un myth.</p> <a
                      href="#">DETAILS</a>
                    </li>
                    <li>
                      <h2>Automotive</h2>
                      <p>Litot Europa usa li sam vocabular.</p> <a
                      href="#">DETAILS</a>
                    </li>
                    <li>
                      <h2>Chemicals</h2>
                      <p>Por scientie musica sport ete</p> <a href="#">DETAILS</a>
                    </li>
                  </ul>
                </div>
                <!-- //showcase-right -->
              </div>
              <!-- //col-md-5 -->
            </div>
            <!-- //row -->
          </div>
          <!-- //box-shadow-area -->
        </div>
        <!-- //container -->

        <div class="container">
          <div class="row">
            <div class="col-md-5 less-pad-right">
              <div
                class="mt-15 box-wrapper sm-mrgright-15 xs-mrgright-15">
                <article>
                  <header>
                    <img alt="" src="img/img1.jpg"
                      class="img-responsive">
                  </header>
                  <div class="welcome-text">
                    <h2>Welcome to Industrix</h2>
                    <p>Class aptent taciti sociosqu ad litora
                      torquent per conubia nostra, per inceptos
                      himenaeos. Maecenas venenatis sollicitudin neque,
                      vel rhoncus sem suscipit id.</p>
                    <div class="readmore">
                      <a href="#">More</a>
                    </div>
                  </div>
                  <!-- //welcome-text -->
                </article>
              </div>
            </div>
            <!-- //col-md-5 -->
            <div class="col-md-7">
              <div class="mt-15 box-wrapper">
                <div class="product-slider">
                  <h2 class="lead-title">
                    <span>Our Product</span><span class="lead-sub-title">Est
                      omnis doloresereledusemp- quibdameto aurerumoms
                      odes necessitatibus saepe eveniet</span>
                  </h2>
                  <div id="css-demo" class="css-product">
                    <div class="product-item">
                      <img src="img/demo1.jpg" alt="Demo Image" />
                      <div class="single-product">
                        <h4>
                          <a href="#">Gasolin</a>
                        </h4>
                        <span>Sed commodo dolor vel velit
                          elementum eget volutpat nisi</span>
                        <div class="readmore">
                          <a href="">More</a>
                        </div>
                      </div>
                    </div>
                    <!-- //product-item -->
                    <div class="product-item">
                      <img src="img/demo1.jpg" alt="Demo Image" />
                      <div class="single-product">
                        <h4>
                          <a href="#">Gasolin</a>
                        </h4>
                        <span>Sed commodo dolor vel velit
                          elementum eget volutpat nisi</span>
                        <div class="readmore">
                          <a href="">More</a>
                        </div>
                      </div>
                    </div>
                    <!-- //product-item -->
                    <div class="product-item">
                      <img src="img/demo1.jpg" alt="Demo Image" />
                      <div class="single-product">
                        <h4>
                          <a href="#">Gasolin</a>
                        </h4>
                        <span>Sed commodo dolor vel velit
                          elementum eget volutpat nisi</span>
                        <div class="readmore">
                          <a href="">More</a>
                        </div>
                      </div>
                    </div>
                    <!-- //product-item -->
                    <div class="product-item">
                      <img src="img/demo1.jpg" alt="Demo Image" />
                      <div class="single-product">
                        <h4>
                          <a href="#">Gasolin</a>
                        </h4>
                        <span>Sed commodo dolor vel velit
                          elementum eget volutpat nisi</span>
                        <div class="readmore">
                          <a href="">More</a>
                        </div>
                      </div>
                    </div>
                    <!-- //product-item -->
                    <div class="product-item">
                      <img src="img/demo1.jpg" alt="Demo Image" />
                      <div class="single-product">
                        <h4>
                          <a href="#">Gasolin</a>
                        </h4>
                        <span>Sed commodo dolor vel velit
                          elementum eget volutpat nisi</span>
                        <div class="readmore">
                          <a href="">More</a>
                        </div>
                      </div>
                    </div>
                    <!-- //product-item -->
                    <div class="product-item">
                      <img src="img/demo1.jpg" alt="Demo Image" />
                      <div class="single-product">
                        <h4>
                          <a href="#">Gasolin</a>
                        </h4>
                        <span>Sed commodo dolor vel velit
                          elementum eget volutpat nisi</span>
                        <div class="readmore">
                          <a href="">More</a>
                        </div>
                      </div>
                    </div>
                    <!-- //product-item -->
                    <div class="product-item">
                      <img src="img/demo1.jpg" alt="Demo Image" />
                      <div class="single-product">
                        <h4>
                          <a href="#">Gasolin</a>
                        </h4>
                        <span>Sed commodo dolor vel velit
                          elementum eget volutpat nisi</span>
                        <div class="readmore">
                          <a href="">More</a>
                        </div>
                      </div>
                    </div>
                    <!-- //product-item -->
                    <div class="product-item">
                      <img src="img/demo1.jpg" alt="Demo Image" />
                      <div class="single-product">
                        <h4>
                          <a href="#">Gasolin</a>
                        </h4>
                        <span>Sed commodo dolor vel velit
                          elementum eget volutpat nisi</span>
                        <div class="readmore">
                          <a href="">More</a>
                        </div>
                      </div>
                    </div>
                    <!-- //product-item -->
                  </div>
                  <!-- //css-product -->
                  <div class="customNavigation css-product-navigation">
                    <a class="next"><i class="fa fa-angle-right"></i></a>
                    <a class="prev"><i class="fa fa-angle-left"></i></a>
                  </div>
                  <!-- //css-product-navigation -->
                </div>
                <!-- //product-slider -->
              </div>
            </div>
            <!-- //col-md-7 -->
          </div>
          <!-- //row -->
        </div>
        <!-- //container -->

        <div class="container">
          <div class="row">
            <div class="col-md-8 col-sm-12 col-xs-12 less-pad-right">
              <div
                class="tab-area mt-15 box-wrapper  sm-mrgright-15 xs-mrgright-15">
                <div id="tabs" class="home-tab">
                  <!-- Nav tabs -->
                  <ul class="nav nav-tabs">
                    <li class="active"><a href="#portfolio"
                      data-toggle="tab"><i class="fa fa-briefcase"></i>&nbsp;
                        Company Profile</a></li>
                    <li><a href="#magazin" data-toggle="tab"><i
                        class="fa fa-folder"></i>&nbsp; Company Magazine</a></li>
                    <li><a href="#valu" data-toggle="tab"><i
                        class="fa fa-heart"></i>&nbsp; Corporate values</a></li>
                  </ul>
                  <!-- Tab panes -->
                  <div class="tab_container">
                    <div class="tab-content">
                      <div class="tab-pane active" id="portfolio">
                        <img src="img/tab_img.jpg" alt="" />
                        <h4>LOREM IPSUM DOLOR SIT AMET</h4>
                        <h5>Consec tetuer adipicing it. Praesebul.</h5>
                        <p>Integer vel nulla ut erat faucibus auctor
                          in in felis. Proin a justo arcu. Sed commodo
                          dolor vel velit elementum eget volutpat nisi
                          placerat. In tellus nulla, lacinia a
                          vestibulum at, dapibus sed lorem. Nunc porta
                          pharetra sollicitudin. Quisque a risus eu
                          lectus fringilla sodales eu ac felis.
                          Suspendisse potenti. Etiam at semper enim.</p>
                        <p>Nunc varius mauris leo, ut facilisis
                          orci. Praesent vehicula, lectus id condimentum
                          suscipit, ipsum mauris vulputate elit, quis
                          auctor turpis magna fringilla justo.</p>
                      </div>
                      <!-- //portfolio-tab -->
                      <div class="tab-pane" id="magazin">
                        <img
                          src="img/4ee759ab65ed601799cfe58516064bd8_240_0.jpg"
                          alt="" />
                        <h4>LOREM IPSUM DOLOR SIT AMET</h4>
                        <h5>Consec tetuer adipicing it. Praesebul.</h5>
                        <p>Integer vel nulla ut erat faucibus auctor
                          in in felis. Proin a justo arcu. Sed commodo
                          dolor vel velit elementum eget volutpat nisi
                          placerat. In tellus nulla, lacinia a
                          vestibulum at, dapibus sed lorem. Nunc porta
                          pharetra sollicitudin. Quisque a risus eu
                          lectus fringilla sodales eu ac felis.
                          Suspendisse potenti. Etiam at semper enim.</p>
                        <p>Nunc varius mauris leo, ut facilisis
                          orci. Praesent vehicula, lectus id condimentum
                          suscipit, ipsum mauris vulputate elit, quis
                          auctor turpis magna fringilla justo.</p>
                      </div>
                      <!-- //magazin-tab -->
                      <div class="tab-pane" id="valu">
                        <img src="img/demo5.png" alt="" />
                        <h4>Yearly Investment</h4>
                        <div class="progress">
                          <div style="width: 30%;"
                            class="progress-bar progress-bar-danger">
                            <span class="sr-only">40% Complete
                              (success)</span>
                          </div>
                        </div>
                        <h4>Yearly Production</h4>
                        <div class="progress">
                          <div style="width: 60%;"
                            class="progress-bar progress-bar-info">
                            <span class="sr-only">40% Complete
                              (success)</span>
                          </div>
                        </div>
                        <h4>Yearly Profit</h4>
                        <div class="progress">
                          <div style="width: 90%;"
                            class="progress-bar progress-bar-success">
                            <span class="sr-only">40% Complete
                              (success)</span>
                          </div>
                        </div>
                      </div>
                      <!-- //valu-tab -->
                    </div>
                    <!-- //tab-content -->
                  </div>
                  <!-- //tab_container -->
                </div>
                <!-- //home-tab -->
              </div>
              <!-- tab-area -->
            </div>
            <!-- col-md-8 -->

            <div class="col-md-4 col-sm-12 col-xs-12">
              <div class="accordion-area mt-15 box-wrapper">
                <h2 class="lead-title">Why Industrix?</h2>
                <div class="panel-group" id="accordion">
                  <div class="panel panel-default panel-faq">
                    <div class="panel-heading">
                      <a data-toggle="collapse" data-parent="#accordion"
                        href="#section1">
                        <h4 class="panel-title">
                          Who we are? <span class="pull-right"><i
                            class="fa fa-minus-square"></i></span>
                        </h4>
                      </a>
                    </div>
                    <div id="section1"
                      class="panel-collapse collapse in">
                      <div class="panel-body">Anim pariatur cliche
                        reprehenderit, enim eiusmod high life accusamus
                        terry richardson ad squid. 3 wolf moon officia
                        aute, non cupidatat skateboard dolor brunch.</div>
                    </div>
                  </div>
                  <div class="panel panel-default panel-faq">
                    <div class="panel-heading">
                      <a data-toggle="collapse" data-parent="#accordion"
                        href="#section2">
                        <h4 class="panel-title">
                          What we do? <span class="pull-right"><i
                            class="fa fa-plus-square"></i></span>
                        </h4>
                      </a>
                    </div>
                    <div id="section2" class="panel-collapse collapse">
                      <div class="panel-body">Anim pariatur cliche
                        reprehenderit, enim eiusmod high life accusamus
                        terry richardson ad squid. 3 wolf moon officia
                        aute, non cupidatat skateboard dolor brunch.</div>
                    </div>
                  </div>
                  <div class="panel panel-default panel-faq">
                    <div class="panel-heading">
                      <a data-toggle="collapse" data-parent="#accordion"
                        href="#section3">
                        <h4 class="panel-title">
                          Why we do it? <span class="pull-right"><i
                            class="fa fa-plus-square"></i></span>
                        </h4>
                      </a>
                    </div>
                    <div id="section3" class="panel-collapse collapse">
                      <div class="panel-body">Anim pariatur cliche
                        reprehenderit, enim eiusmod high life accusamus
                        terry richardson ad squid. 3 wolf moon officia
                        aute, non cupidatat skateboard dolor brunch.</div>
                    </div>
                  </div>
                  <div class="panel panel-default panel-faq">
                    <div class="panel-heading">
                      <a data-toggle="collapse" data-parent="#accordion"
                        href="#section4">
                        <h4 class="panel-title">
                          How we do it? <span class="pull-right"><i
                            class="fa fa-plus-square"></i></span>
                        </h4>
                      </a>
                    </div>
                    <div id="section4" class="panel-collapse collapse">
                      <div class="panel-body">Anim pariatur cliche
                        reprehenderit, enim eiusmod high life accusamus
                        terry richardson ad squid. 3 wolf moon officia
                        aute, non cupidatat skateboard dolor brunch</div>
                    </div>
                  </div>
                </div>
              </div>
              <!-- accordion-area -->
            </div>
            <!-- col-md-4 -->
          </div>
          <!-- //row -->

          <div class="row">
            <div class="col-md-8 col-sm-12 col-xs-12 less-pad-right">
              <div
                class="latest-news-area mt-15 box-wrapper sm-mrgright-15 xs-mrgright-15">
                <h2 class="lead-title">Latest News &amp; Events</h2>
                <div class="latest-news-caruosel">
                  <div id="latest-news" class="latest-news">
                    <div class="item">
                      <div class="single-latest">
                        <img src="img/news-img1.jpg" alt="" />
                        <p class="date-meta">04 March 2014</p>
                        <h4>AENEAN NEC SEMPERSEM</h4>
                        <p>Lorem ipsum dolor sit amet,consec tetuer
                          adipiscing. Praesentvestibu. lum
                          molestielacuiirhs. Aenean non ummy
                          hendreriauris.</p>
                        <div class="readmore">
                          <a href="">More</a>
                        </div>
                      </div>
                    </div>
                    <div class="item">
                      <div class="single-latest">
                        <img src="img/news-img3.jpg" alt="" />
                        <p class="date-meta">04 March 2014</p>
                        <h4>AENEAN NEC SEMPERSEM</h4>
                        <p>Lorem ipsum dolor sit amet,consec tetuer
                          adipiscing. Praesentvestibu. lum
                          molestielacuiirhs. Aenean non ummy
                          hendreriauris.</p>
                        <div class="readmore">
                          <a href="">More</a>
                        </div>
                      </div>
                    </div>
                    <div class="item">
                      <div class="single-latest">
                        <img src="img/news-img1.jpg" alt="" />
                        <p class="date-meta">04 March 2014</p>
                        <h4>AENEAN NEC SEMPERSEM</h4>
                        <p>Lorem ipsum dolor sit amet,consec tetuer
                          adipiscing. Praesentvestibu. lum
                          molestielacuiirhs. Aenean non ummy
                          hendreriauris.</p>
                        <div class="readmore">
                          <a href="">More</a>
                        </div>
                      </div>
                    </div>
                    <div class="item">
                      <div class="single-latest">
                        <img src="img/news-img3.jpg" alt="" />
                        <p class="date-meta">04 March 2014</p>
                        <h4>AENEAN NEC SEMPERSEM</h4>
                        <p>Lorem ipsum dolor sit amet,consec tetuer
                          adipiscing. Praesentvestibu. lum
                          molestielacuiirhs. Aenean non ummy
                          hendreriauris.</p>
                        <div class="readmore">
                          <a href="">More</a>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="customNavigation latest-news-navigation">
                    <a class="next"><i class="fa fa-angle-right"></i></a>
                    <a class="prev"><i class="fa fa-angle-left"></i></a>
                  </div>
                </div>
              </div>
            </div>
            <!-- //col-md-8 -->
            <div class="col-md-4 col-sm-12 col-xs-12">
              <div class="testimonial-area mt-15 box-wrapper ">
                <h2 class="lead-title">Our Client say's</h2>
                <div class="client-testimonial-caruosel">
                  <div id="client-testimonial"
                    class="client-testimonial">
                    <div class="item">
                      <div class="testimonial">
                        <p>
                          <i class="fa fa-quote-left"></i> Aenean
                          nonummy hendrerit mau phasellu porta. Fusce
                          suscipit varius mi sed. Cum sociis natoque
                          penatibus et magnis dis parturient montes,
                          nascetur ridiculus mus. Nulla dui. Fusce
                          feugiat malesuada odio morbi. Ut viverra
                          mauris justo, quis auctor nisi. Suspendisse
                          sit amet diam diam, eget volutpat lacus.<i
                            class="fa fa-quote-right"></i>
                        </p>
                      </div>
                      <img src="img/testimonial-img1.jpg" alt="" />
                      <p class="name">
                        Mark Johnson, <span class="position">Manager</span>
                      </p>
                      <p class="company">ThemeHippo</p>
                    </div>
                    <div class="item">
                      <div class="testimonial">
                        <p>
                          <i class="fa fa-quote-left"></i> Aenean
                          nonummy hendrerit mau phasellu porta. Fusce
                          suscipit varius mi sed. Cum sociis natoque
                          penatibus et magnis dis parturient montes,
                          nascetur ridiculus mus. Nulla dui. Fusce
                          feugiat malesuada odio morbi. Ut viverra
                          mauris justo, quis auctor nisi. Suspendisse
                          sit amet diam diam, eget volutpat lacus.<i
                            class="fa fa-quote-right"></i>
                        </p>
                      </div>
                      <img src="img/testimonial-img1.jpg" alt="" />
                      <p class="name">
                        Mark Johnson, <span class="position">Manager</span>
                      </p>
                      <p class="company">ThemeHippo</p>
                    </div>
                    <div class="item">
                      <div class="testimonial">
                        <p>
                          <i class="fa fa-quote-left"></i> Aenean
                          nonummy hendrerit mau phasellu porta. Fusce
                          suscipit varius mi sed. Cum sociis natoque
                          penatibus et magnis dis parturient montes,
                          nascetur ridiculus mus. Nulla dui. Fusce
                          feugiat malesuada odio morbi. Ut viverra
                          mauris justo, quis auctor nisi. Suspendisse
                          sit amet diam diam, eget volutpat lacus.<i
                            class="fa fa-quote-right"></i>
                        </p>
                      </div>
                      <img src="img/testimonial-img1.jpg" alt="" />
                      <p class="name">
                        Mark Johnson, <span class="position">Manager</span>
                      </p>
                      <p class="company">ThemeHippo</p>
                    </div>
                  </div>
                  <!-- //client-testimonial -->
                  <div
                    class="customNavigation client-testimonial-navigation">
                    <a class="next"><i class="fa fa-angle-right"></i></a>
                    <a class="prev"><i class="fa fa-angle-left"></i></a>
                  </div>
                  <!-- //client-testimonial-navigation -->
                </div>
                <!-- //client-testimonial-caruosel -->
              </div>
              <!-- //testimonial-area -->
            </div>
            <!-- //col-md-4 -->
          </div>
          <!-- //row -->
        </div>
        <!-- //container -->

        <div class="container">
          <div class="row">
            <div class="col-md-12">
              <div class="client-logo mt-15 box-wrapper ">
                <h3>Our Partners</h3>
                <div class="client-logo-caruosel">
                  <div class="clients">
                    <div class="item">
                      <img src="img/client.jpg" alt="Demo Image" />
                    </div>
                    <div class="item">
                      <img src="img/client2.jpg" alt="Demo Image" />
                    </div>
                    <div class="item">
                      <img src="img/client3.jpg" alt="Demo Image" />
                    </div>
                    <div class="item">
                      <img src="img/client4.jpg" alt="Demo Image" />
                    </div>
                    <div class="item">
                      <img src="img/client5.jpg" alt="Demo Image" />
                    </div>
                    <div class="item">
                      <img src="img/client.jpg" alt="Demo Image" />
                    </div>
                    <div class="item">
                      <img src="img/client3.jpg" alt="Demo Image" />
                    </div>
                    <div class="item">
                      <img src="img/client4.jpg" alt="Demo Image" />
                    </div>
                    <div class="item">
                      <img src="img/client5.jpg" alt="Demo Image" />
                    </div>
                  </div>
                  <!-- //clients -->
                  <div class="customNavigation clients-navigation">
                    <a class="next"><i class="fa fa-angle-right"></i></a>
                    <a class="prev"><i class="fa fa-angle-left"></i></a>
                  </div>
                  <!-- clients-navigation -->
                </div>
                <!-- //client-logo-carousel -->
              </div>
              <!-- //client-logo -->
            </div>
            <!-- //col-md-12 -->
          </div>
          <!-- //row -->
        </div>
        <!-- //container -->
        <!-- logo and social media -->
        <!-- being footer -->
        <jsp:include page="include/footer.jsp" />
        <!-- end footer -->
      </div>
      <!-- //inner-wrapper -->
    </div>
    <!-- //row-offcanvas -->
  </div>
  <!-- //wrapper -->

  <!--Start script-->
  <script src="js/jquery-1.7.2.min.js"></script>
  <script src="js/modernizr-2.6.2.min.js"></script>
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
  <!--End script    -->
</body>
</html>