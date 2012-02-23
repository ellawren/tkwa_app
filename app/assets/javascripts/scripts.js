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




	
	