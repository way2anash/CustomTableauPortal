

  
function document_ready() {

  var vizDiv = document.getElementById('viz');
  var vizURL = "http://public.tableau.com/views/JSAPIExamples/LineChart";
  isPublic = true;
  //var vizURL = "http://localhost/views/JSAPIExamples/LineChart";
  //window.alert("fullURL: " + fullURL);
  //var vizURL = "<%= fullURL %>";
  
  var options = {
    height: '450px',
    width: '765px' //,
    //hideTabs: true,
    //hideToolbar: true,
    //onFirstInteractive: function() {
    //  utilitiesSetup();
    //}
  }
 
  //viz = new tableauSoftware.Viz(vizDiv, vizURL, options);
  viz = new tableauSoftware.Viz(vizDiv, vizURL, options);
   
} 
 /**
 * 
 */