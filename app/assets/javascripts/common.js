
// Set the active tab, if there is one
$(document).ready(function (){
  var controller = document.URL.split("/")[4]
  var undefined // This is a hack that works with older JS versions
  if ( controller == undefined || controller == "#") controller = "home"
  $("#" + controller + "_link").addClass("active")
});