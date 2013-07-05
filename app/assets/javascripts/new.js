$(document).ready(function() {

	// main nav hover controls
    $("ul#nav li.active").hover(function () {
      $(this).children(".control-icons").stop().fadeToggle("slow");
    });


});
