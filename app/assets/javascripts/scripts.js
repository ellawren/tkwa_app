$(function() {
		$(".pop").popover({ placement: 'right', animation:true });
		$(".tip").tooltip({ animation: true, placement: 'top', trigger:'hover' });
		
});


function copyContact() {
	document.getElementById("project_billing_name").value = document.getElementById("project_contact_name").value;
	document.getElementById("project_billing_phone").value = document.getElementById("project_contact_phone").value;
	document.getElementById("project_ext").value = document.getElementById("project_contact_ext").value;
	document.getElementById("project_billing_email").value = document.getElementById("project_contact_email").value;
}

// toggle contact list view on projects/team page
$(document).ready(function() {
	$("#team-staff").click(function () {
    	$( ".team-consultants" ).css( "display","none" );
    	$( ".team-staff" ).css( "display","block" );
  	});

  	$("#team-consultants").click(function () {
    	$( ".team-staff" ).css( "display","none" );
    	$( ".team-consultants" ).css( "display","block" );
  	});

  	$("#team-all").click(function () {
    	$( ".team-consultants" ).css( "display","block" );
    	$( ".team-staff" ).css( "display","block" );
  	});

});

// toggle scope edit on projects/scope page
$(document).ready(function() {
	$("#scope-toggle").one( "click", function () {
    	$( "#scope-summary" ).css( "display","none" );
    	$( "#scope-edit" ).css( "display","block" );
  	});

});


	
	