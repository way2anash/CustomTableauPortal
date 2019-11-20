<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
  
<%@ page import="java.io.*,java.sql.*,javax.naming.*" %>
<%@ page import="tabRest.tabRest,com.tableau.oem.*,com.google.common.io.*,java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<!-- Begin all page-level Java -->
<%
ManufacturingUtils utils = new ManufacturingUtils();

String viewName = "";
String username = "";

if (request.getSession(false) != null)
{
	username = (String) session.getAttribute("username");
	username = ((username == null) ? "" : username);
	session.setAttribute("username", username);
}
else
{
	session.setAttribute("username", "");
}

// -- let's embed Viz
String vizUrl = "";
String wkbkName = "";
String vwName = "";

if (username.length() > 0) 
{
  wkbkName = request.getParameter("workbook");
  vwName = request.getParameter("view");
  
  // -- Get trusted ticket
  String trustedTicket = utils.getTrustedTicket(
	   ManufacturingUtils.SERVER_URL, ManufacturingUtils.SITE, 
       username);                       
  
  // -- TIP: Use the "/t" vs "/site" URL format to be compatible with Tableau Online
  vizUrl = ManufacturingUtils.SERVER_URL + "/trusted/" + trustedTicket + "/t/" +  
		  ManufacturingUtils.SITE + "/views/" + wkbkName + "/" + vwName +
          "?embed:=y";

  // -- let's expose values in client-side script
  out.println("<script type=\"text/javascript\">");
  out.println("    var vizUrl=\"" + vizUrl + "\";");
  out.println("</script>");

  // -- add dynamic reference to JS library
  out.println("<script src=\"http://" + ManufacturingUtils.TABLEAU_SERVER_HOST + ":" + 
		  ManufacturingUtils.TABLEAU_SERVER_PORT + 
          "/javascripts/api/tableau-2.min.js\"></script>");
  
  System.out.println("    var vizUrl=\"" + vizUrl + "\";"); 
} 
%>
<!-- End all page-level Java -->

<!DOCTYPE html>

<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js">
<!--<![endif]-->

<head>

<script src="./js/jquery-1.7.2.min.js" type="text/javascript"></script>

<script type="text/javascript">

	// TIP: Declare a page-level variable to hold the workbook object, and initialize in
	//      onFirstInteractive event handler
	var book;
	// TIP: The variable you declare to hold the Viz object should also be a page-level
	//      variable
	var viz;
  	
	// -- Basic recipe for creating a dynamic UI for your users
	//
	//    1) Create an HTML DIV where you want your Viz to appear, and assign it a unique ID
	//    2) Define page-level variables to hold the viz and workbook objects
	//    3) Place the JavaScript (JS) code that instantiates your Viz in the window_onload event
	//       handler, or, if using jQuery, use $(document).ready
	//    4) Use standard HTML DOM and JS (not jQuery) to create instantiate a variable representing 
	//       the HTML DIV
	//    5) Optionally, define an array of options for loading the Viz. It is in this array of options
	//       that you would specifiy an event handler for onFirstInteractive - the event that fires
	//       once the Viz is rendered and ready for user interaction
	//    6) If you define and event handler for onFirstInteractive (recommended), initialize  
	//       the page-level variable you defined to hold the workbook object
	//    7) Define any event handlers you will use in the onFirstInteractive function as well
	//    8) Load the Viz!	
	
  	// -- Render the Viz after the web page has loaded (using jQuery, here)
	$(document).ready( 
  			
  	    function() {	
  		
    		// TIP: For initializing the Viz variable, use traditional DOM model, not jQuery
  	    	var vizDiv = document.getElementById("viz");
    		
    		var vizOptions = {
      		  hideTabs: true,
      		  hideToolbar: true,
      		  // -- assign event handler for onFirstInteractive 
      		  onFirstInteractive: completeLoad
    		} 
    
    		console.log("Creating Viz using URL: " + vizUrl);
    		viz = new tableauSoftware.Viz(vizDiv, vizUrl, vizOptions);
  		
  		} // function
  
  	); // $(document).ready( function(...)		  
		  
  	function completeLoad(e) {
		
        // -- Assign values to page-level cars
        console.log('Viz is now loaded and available');
        book = viz.getWorkbook();   
        sheetInfo = book.getPublishedSheetsInfo(); 
		             
		var activeSheet = book.getActiveSheet();
		var activeSheetName = activeSheet.getName();        
        
		// TIP: Example of modifying portal UI based on content of embedded Viz
		var worksheetButtonsHTML = "";
		// TIP: Here's how we check to see if the embedded Viz is one of
		//      several Vizzes published from the same workbook
		if (sheetInfo.length > 1) {			
			
			// -- dynamic HTML to create buttons for tabs of workbook
			for (i = 0; i < sheetInfo.length; i++)
			{	
				var curSheetInfo = sheetInfo[i]; 
				// -- not going to do anything with tabs when story 
				if (curSheetInfo.getSheetType()==tableau.SheetType.STORY)
				{
					worksheetButtonsHTML = "";
					break;
				}				
				var curSheetName = curSheetInfo.getName();
				worksheetButtonsHTML +=
					"<button id=vizTab" + i + " onclick='activateTab(" + i + ");' ";				
				if (curSheetName == activeSheetName)
				{
					worksheetButtonsHTML += " disabled ";
				}	
				worksheetButtonsHTML +=	
					">Show " + curSheetName + " View</button>&nbsp;&nbsp;&nbsp;&nbsp;";													
			}
		} // -- if (sheetInfo.length > 1)
			
		// -- display any additional buttons	
		if (worksheetButtonsHTML!="")
			$("#vizButtons").html($("#vizButtons").html() + worksheetButtonsHTML);
                
        // -- add mark(s) selection event listener here 
        viz.addEventListener(tableauSoftware.TableauEventName.MARKS_SELECTION, onMarksSelection);
           
    } // -- complete load function

	// -- respond to marks selection event
	function onMarksSelection(marksEvent) {
    	
	  		$('#selectedMarksSummary').hide();
			return marksEvent.getMarksAsync().then(handleSelectedMarks);
	}	

	// -- This function is called after we get an array of marks from our mark selection event
	function handleSelectedMarks(marks) {
		
		if (marks.length == 0)
		{
			$('#selectedMarksSummary').html("");
			
		} 		
		else
		{
			$('#selectedMarksSummary').html("<br />You selected " + marks.length + " mark(s)");
    		$('#selectedMarksSummary').show();
		}
	}	
        
    // -- this function is triggered by a button click in the UI
    function clearSelections(){   	
        var sheet = book.getActiveSheet();
        // TIP: You frequently need to check to see if you are working with
        //      a dashboard or a single-Viz view
        if ( sheet.getWorksheets ) {
            sheets = sheet.getWorksheets();
            for(i = 0; i < sheets.length; i++) {
            	// TIP: When you clear marks on a dashboard, you have to cycle through
            	//      each member Viz
                sheets[i].clearSelectedMarksAsync();
            }
        }
        else {
            sheet.clearSelectedMarksAsync();
        }
    }
    
 	// -- this function is triggered by a button click in the UI
    function pdfExport() {
        viz.showExportPDFDialog();
    }    
    	
	// -- for navigating tabs of multi-tab published workbook
 	function activateTab(tabIndex)
	{
		book.activateSheetAsync(tabIndex);
		// -- hide anything else that may be open in connection with current tab
  		$('#downloadDataDiv').hide();
  		$('#selectedMarksSummary').hide();
		for (i = 0; i < sheetInfo.length; i++) 
		{	
			if (i==tabIndex) 
			{
				$("#vizTab" + i).prop('disabled', true);	
			}
			else
			{
				$("#vizTab" + i).prop('disabled', false);	
			}
		}
	}   
 	
 	// -- this function is triggered by a button click in the UI
 	//    presents UI it getData() options to user
    function showDownloadDataUI(){
		
	 	$('#editingForm').hide();
		if ( $("#downloadDataDiv").is(":visible") )
		{    
			// -- enable buttons
			$('#btnClearSelections').prop('disabled', false);			
			$("#downloadDataDiv").hide();
			
		}
		else
		{
			$('#btnClearSelections').prop('disabled', true);			
			 			
		    //TIP: Building an HTML select from the names of
		    //     consistuent Vizzes
		    $('#selWorksheets').find('option').remove();
		
    	    var wkshtToExport = "";
    	    
  			if (viz.getWorkbook().getActiveSheet().getWorksheets) 
  			{
      	    	var worksheets = viz.getWorkbook().getActiveSheet().getWorksheets();
      	    	for (var w = 0; w < worksheets.length; w++)
      	    	{
      		    	var worksheet = worksheets[w];
      		    	var worksheetName = worksheet.getName();
      		    	$('#selWorksheets').append($('<option>', {value:worksheetName, text:worksheetName}));
      	    	}
  			}
      		else
      		{
  		    	var worksheetName = viz.getWorkbook().getActiveSheet().getName();
  		    	$('#selWorksheets').append($('<option>', {value:worksheetName, text:worksheetName}));        				
      		}     	  
    	    $('#downloadDataDiv').show();	 		
		} // -- if ( $("#downloadDataDiv").is(":visible") ) 
	}	

	// -- triggered when user clicks Submit in download data form
 	function downloadData()
	{
		
  		var worksheet = $('select[name="selWorksheets"]').val();
   		var detailLevel = $('#downloadDataForm').find('input[name="detailLevel"]').val();
   		var includeFilter = $('#downloadDataForm').find('input[name="includeFilter"]').val();
   		var maxRows = $('#downloadDataForm').find('input[name="noRows"]').val();
    		  
   		maxRows = ((maxRows=='All') ? 0 : maxRows);
    		  
    	// -- get current worksheet	  
    	if (viz.getWorkbook().getActiveSheet().getWorksheets)
			sheet = viz.getWorkbook().getActiveSheet().getWorksheets().get(worksheet);
    	else
    		sheet = viz.getWorkbook().getActiveSheet();

    	var getDataOptions;
		var dataString = "";
		if (detailLevel == "summary")
		{
			getDataOptions = {
            	maxRows: maxRows, // Max rows to return. Use 0 to return all rows
                ignoreAliases: false,
                ignoreSelection: ((includeFilter=="no") ? true : false) 
            };		
             
            sheet.getSummaryDataAsync(getDataOptions).then( 
            	function(t) {
            		table = t;
                	exportDataAsCsv(table, worksheet);
          		}
            );
		}
		else
		{
			getDataOptions = {
            	maxRows: maxRows, // Max rows to return. Use 0 to return all rows
            	ignoreAliases: false,
            	includeAllColumns: false,
				ignoreSelection: ((includeFilter=="no") ? true : false) 
			};	
             
            sheet.getUnderlyingDataAsync(getDataOptions).then( 
            	function(t) {
                	table = t;
                  	exportDataAsCsv(table, worksheet);
           		}
            );             
             
		} // -- if (detailLevel == "summary")
		 
		// -- clean up UI
		cleanupDownloadDataUI();		 
			 
	} // -- function downloadData
	
	// -- cancel data download, cleanup UI
	function cleanupDownloadDataUI()
	{
		 $('#downloadDataDiv').hide();
		 $('#btnClearSelections').prop('disabled', false);
		 $('#btnExportWorksheetData').prop('disabled', false);		 
	}
	
	// -- package retrieved data as .csv and make available to user for download
	function exportDataAsCsv(table, worksheet)
	{
		var data = table.getData();
		var cols = table.getColumns();

		var line = [];
		var dataString = "";
		var csv = [];
		
		for (c = 0; c < cols.length; c++)
		{
			line.push(cols[c].getFieldName());
			if (c < (cols.length - 1))
			{
				line.push(",");
			}
			
		} // -- get col names
		line.push("\n");
		
		dataString = line.join("");
		line = [];
		
		console.log(dataString);
		csv.push(dataString);
		
		// -- get data
		for (r = 0; r < data.length; r++)
		{
			var colValues = data[r];		
			for (v = 0; v < colValues.length; v++)
			{
				var val = colValues[v].value;
				line.push(val);
				if (v < (colValues.length - 1))
				{
					line.push(",");
				}
				
			}
			
			line.push("\n");
			dataString = line.join("");
			line = [];
			csv.push(dataString);
		} // -- get row data
		
		// TIP: Handy way to trigger a download of a file entirely from
		//      local, JavaScript code
		var csvOutput = csv.join("");
		var element = document.createElement('a');
		element.setAttribute('href', 'data:text/plain;charset=utf-8,' + encodeURIComponent(csvOutput));
		var fileName = worksheet.replace(/[|&;$%@""<>()+,]/g, '') + ".csv";
		element.setAttribute('download', fileName);
		element.style.display = 'none';
		document.body.appendChild(element);
		element.click();
		document.body.removeChild(element);
	}
   
</script>

<style>

  button  {
    background-color: #383838 !important; /* Black */
    border: none;
    /* color: white !important; */
    color: #BEBEBE !important;
    padding: 15px 15px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    font-family: "Roboto Condensed", Helvetica, Arial, sans-serif;
    font-weight: 300;
    text-transform: uppercase;
    
  }

  button:hover
  {
    background-color: #2F2F2F !important; 
    color: white !important;
  }

  </style>
 
  <!-- for web edit modal dialog -->
  <style>
  
  .modalDialog {
    position: fixed;
    font-family: Arial, Helvetica, sans-serif;
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;
    background: rgba(0,0,0,0.8);
    z-index: 99999;
    opacity:0;
    -webkit-transition: opacity 400ms ease-in;
    -moz-transition: opacity 400ms ease-in;
    transition: opacity 400ms ease-in;
    pointer-events: none;
  }
  
  .modalDialog:target {
    opacity:1;
    pointer-events: auto;
  }

  .modalDialog > div {
    width: 400px;
    position: relative;
    margin: 10% auto;
    padding: 5px 20px 13px 20px;
    border-radius: 10px;
    background: #fff;
    background: -moz-linear-gradient(#fff, #999);
    background: -webkit-linear-gradient(#fff, #999);
    background: -o-linear-gradient(#fff, #999);
  }  
  
 .close {
    background: #606061;
    color: #FFFFFF;
    line-height: 25px;
    position: absolute;
    right: -12px;
    text-align: center;
    top: -10px;
    width: 24px;
    text-decoration: none;
    font-weight: bold;
    -webkit-border-radius: 12px;
    -moz-border-radius: 12px;
    border-radius: 12px;
    -moz-box-shadow: 1px 1px 3px #000;
    -webkit-box-shadow: 1px 1px 3px #000;
    box-shadow: 1px 1px 3px #000;
  }

  .close:hover { 
    background: #00d9ff; 
  }
  
  </style>


  <meta charset="utf-8" />
  <title>Industrix</title>
  <meta name="description" content="" />
  <!-- This styles only adds some repairs on idevices  -->
  <meta name="viewport"
    content="width=device-width, initial-scale=1, maximum-scale=1" />
  <!-- Effects for thumbnail images -->
  <link rel="stylesheet" href="css/thumbnailImages.css" />  
  <!-- Favicon -->
  <link rel="shortcut icon" href="img/favicon.png" />
  <!-- Roboto Condensed Webfont -->
  <link
    href='http://fonts.googleapis.com/css?family=Roboto+Condensed:300italic,400italic,400,300,700'
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
        <!-- this is where the contact form goes along with the "contact us" section 
             this tends to be customized on each page -->
        <section class="contact-page-area">
          <div class="container">
            <div class="row">       
              <!-- <div class="col-md-9 less-pad-right"> -->
              <div class="col-md-12">
                <div
                  class="box-wrapper mt-15 sm-mrgright-15 xs-mrgright-15"
                  style="padding-bottom: 20px; padding-top: 5px; padding-left: inherit;" 
                  >
                  <div id="analytics_div">
                    <dl class="contact-address dl-horizontal"></dl>
 
                    <c:if test="${(sessionScope.username eq '')}" >    
                      <h2>Please log in</h2>
                      <br/>You must be logged in to access your Analytics. Click 
                      <a href=./login.jsp>here</a> to log in now.
                    </c:if>

                    <c:if test="${not (sessionScope.username eq '')}" >                    
                      <span id=vizButtons>                   
                        <button  id="btnClearSelections" onclick='clearSelections();'>Clear Selection(s)</button>
                        &nbsp;&nbsp;
                        <button id='btnExporToPdf' onclick='pdfExport();'>Export To PDF</button>
                        &nbsp;&nbsp;
                        <button id='btnExportWorksheetData' onclick='showDownloadDataUI();'>Export Worksheet Data</button>
                        &nbsp;&nbsp;              
                      </span>                   
                    </c:if>
                    
                    <div id="selectedMarksSummary">
                    </div>                    
                  </div>
                  <!-- div id="analytics_div" -->
                </div>
                <!-- contains buttons -->
                
                <div id="downloadDataDiv" 
                  class="box-wrapper mt-15 sm-mrgright-15 xs-mrgright-15"
                  style="padding-bottom: 20px; padding-top: 5px; padding-left: inherit; display:none" 
                  >   
                    <form name="downloadDataForm" id="downloadDataForm" >
                      <label id="worksheetLbl">Select the worksheet from which to export data:&nbsp;</label> 
                      <select id="selWorksheets" name="selWorksheets"></select>                    
                      <br />
                      <label for="detailLevel">Export summary or underlying data?&nbsp;</label>
                      <input type="radio" name="detailLevel" value="underlying">Underlying&nbsp;
                      <input type="radio" name="detailLevel" value="summary" checked>Summary&nbsp;&nbsp;                      
                      <br />
                      <label for="includeFilter">Apply any active filters to exported data?&nbsp;</label>
                      <input type="radio" name="includeFilter" value="yes" checked>yes&nbsp;
                      <input type="radio" name="includeFilter" value="no">no&nbsp;&nbsp;                      
                      <br />
                      <label for="noRows">Select the maximum number of rows to return:&nbsp;</label>
                      <input type="radio" name="noRows" value="100">100&nbsp;
                      <input type="radio" name="noRows" value="500">500&nbsp;&nbsp;
                      <input type="radio" name="noRows" value="All" checked>All&nbsp;                                          
                      <br />   
                      <br />                     
                      <button type="button" onclick="downloadData();">Submit</button>&nbsp;
                      <button type="button" onclick="cleanupDownloadDataUI();">Cancel</button>                                            
                    </form>                                                      
                </div>
                <!-- <div id="downloadDataForm" -->                                                
              </div>
              <!-- <div class="col-md-12"> -->
            </div>
            <!-- end header row for embedding-->
                                  
            <!-- this is where we'll put the viz -->
            <c:if test="${not (sessionScope.username eq '')}" >
            <div class="row">            
              <div class="col-md-12 ">        
                <div
                  class="contact-input-form box-wrapper mt-15 sm-mrgright-15 xs-mrgright-15">  
                                                   
                  <!-- div to hold Viz -->        
                  <div id='viz' style='visibility: visible;'></div> 
                                               
                </div>                              
             </div>                                
            </div>
            </c:if>
         
            <div class="row">
              <div class="col-md-9 less-pad-right">                                  
              </div> <!-- div class="col-md-9 less-pad-right" -->
            </div> <!--  row -->
          </div>
          <!--  div class="container" -->
        </section>
        <!-- footer -->
        <jsp:include page="include/footer.jsp" />              
      </div>
      <div
        class="offcanvas-wrapper col-sm-3 col-xs-3 hidden-lg hidden-md hidden-sm sidebar-offcanvas">
        <div class="sidebar-nav">
          <h2>Sidebar</h2>
          <button type="button" class="close" aria-hidden="true"
            data-toggle="offcanvas">&times;</button>
          <ul>
            <li class="active"><a href="index.jsp">Home</a></li>
            <li><a href="#">Pages</a>
              <ul>
                <li><a href="about.html">About Us</a></li>
                <li><a href="pricing.html">Pricing Table</a></li>
                <li><a href="left_sidebar.html">Left Sidebar</a></li>
                <li><a href="full_width.html">Full Width Page</a></li>
                <li><a href="service.html">Services</a></li>
                <li><a href="project.html">Project</a></li>
              </ul></li>
            <li><a href="blog.html">Blog</a></li>
            <li><a href="faq.html">Faq</a></li>
            <li><a href="contact.html">Contact</a></li>
          </ul>
        </div>
        <!-- //sidebar-nav -->
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