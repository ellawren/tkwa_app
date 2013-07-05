$(document).ready(function() {
  
  //init modal on project tracking page
  $('a.modal-btn').on('click', function(e) {
      e.preventDefault();
      var url = $(this).attr('href');
      $(".modal-body").html('<iframe id="externalSite" width="100%" height="100%" frameborder="0" scrolling="no" allowtransparency="true" src="'+url+'"></iframe>');
  });

  // hover function on search results - projects/contacts index
  $('tr.results-row').click( function() {
      window.location = $(this).find('a').attr('href');
  }).hover( function() {
      $(this).toggleClass('hover');
  });

});






$(document).ready(function() {
    $( ".datepicker" ).datepicker({noOffset: true});
  });

$(document).ready(function() {
  $(".chzn-select").chosen();
  });



function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  //$(link).closest(".input").hide();
  $(link).closest(".table-row").hide();
}

function remove_fields_2(link) {
  $(link).prev("input[type=hidden]").val("1");
  //$(link).closest(".input").hide();
  $(link).closest(".row").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).before(content.replace(regexp, new_id));
  return false;
  changePhase();
  $(".chzn-select").chosen();
}

function add_category_fields(link, cat, content) {
  $('.' + cat).html(content);
  num = parseInt(cat.substr(cat.length - 2)) + 1;
  cat = ".cat0" + num;
  $(cat).show();
  $(link).hide();
  return false;
}

$(document).ready(function() {
    $("a.pop").popover({ placement: 'right', animation:true });
		$("a.tip").tooltip({ animation: true, placement: 'top', trigger:'hover' });
		$("a.tip-bottom").tooltip({ animation: true, placement: 'bottom', trigger:'hover' });
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

// toggle 
$(document).ready(function() {
  $("#submit").click( function () {
      $( "#timesheet_complete" ).val('t');
  });

  $("#unsubmit").click( function () {
      $( "#timesheet_complete" ).val('f');
  });
});

// toggle search options
$(document).ready(function() {
  $("#show-more").click(function () {
      $( "#more-options" ).css( "display","block" );
      $( "#show-more" ).css( "display","none" );
      $( "#hide-more" ).css( "display","block" );
  });


});





//duration function for schedule page


function parseDate(str) {
    var mdy = str.split('-')
      return new Date(mdy[0], mdy[1]-1, mdy[2]);
}

function daydiff(first, second) {
    return Math.floor((second-first)/(1000*60*60*24));
}

function getDuration(){
      start_date = $("#project_start_date").val();
      end_date = $("#project_completion_date").val();

      if (parseDate(end_date) > parseDate(start_date)) {
        count = daydiff(parseDate(start_date), parseDate(end_date) );
        y = Math.floor(count/365.25);
        m = Math.floor((count - (y*365.25))/30.4);
        w = Math.floor((count - (y*365.25) - (m*30.4))/7);

        fullDate = []

        if (y == 0) { years = ""; } else if ( y == 1) { years = y + " year"; fullDate.push(years); } else { years = y + " years"; fullDate.push(years); }
        if (m == 0) { months = ""; } else if ( m == 1) { months = m + " month"; fullDate.push(months); } else { months = m + " months"; fullDate.push(months); }
        if (w == 0) { weeks = ""; } else if ( w == 1) { weeks = w + " week"; fullDate.push(weeks); } else { weeks = w + " weeks"; fullDate.push(weeks); }

        $("#duration").text( fullDate.join(", ") );
     }
}

// unsaved entry hours calc

function getEntryHours() {
  num = $(this).attr('id').replace(/[^0-9]/g, '');
  alert(num);
}

// total hours calc

function getEstHours() {

    pd = $("#employee_team_pd_hours").val() || 0;
    sd = $("#employee_team_sd_hours").val() || 0;
    dd = $("#employee_team_dd_hours").val() || 0;
    cd = $("#employee_team_cd_hours").val() || 0;
    bid = $("#employee_team_bid_hours").val() || 0;
    cca = $("#employee_team_cca_hours").val() || 0;
    inth = $("#employee_team_int_hours").val() || 0;
    his = $("#employee_team_his_hours").val() || 0;
    add = $("#employee_team_add_hours").val() || 0;

    if (pd === "") { pdh = 0; } else { pdh = parseFloat(pd); }
    if (sd === "") { sdh = 0; } else { sdh = parseFloat(sd); }
    if (dd === "") { ddh = 0; } else { ddh = parseFloat(dd); }
    if (cd === "") { cdh = 0; } else { cdh = parseFloat(cd); }
    if (bid === "") { bidh = 0; } else { bidh = parseFloat(bid); }
    if (cca === "") { ccah = 0; } else { ccah = parseFloat(cca); }
    if (inth === "") { inthh = 0; } else { inthh = parseFloat(inth); }
    if (his === "") { hish = 0; } else { hish = parseFloat(his); }
    if (add === "") { addh = 0; } else { addh = parseFloat(add); }

    total = (pdh + sdh + ddh + cdh + bidh + ccah + inthh + hish + addh);

    $("#total-hours").text( total );
}


// modal popup to edit employee team hours

//$(document).ready(function() {

    // Support for AJAX loaded modal window.
    // Focuses on first input textbox after it loads the window.
   // $('[data-toggle="modal"]').click(function(e) {
   // e.preventDefault();
   // var href = $(this).attr('href');
   // if (href.indexOf('#') == 0) {
    //    $(href).modal('open');
    //} else {
    //    $.get(href, function(data) {
    //    $('<div class="modal fade" >' + data + '</div>').modal();
    //    })

    //
    //});

//});


// open map
function openMap(id) {
  address = $("#"+id).text();
  queryString = address.replace(/(\r\n|\n|\r| )/gm,"+");
  window.open('http://maps.google.com/maps?q=' + queryString);
}

// show map
function showMap(id) {
  address = $("#"+id).text();
  queryString = address.replace(/(\r\n|\n|\r| )/gm,"+");
  document.write("<iframe width=\"690\" height=\"350\" frameborder=\"0\" scrolling=\"no\" marginheight=\"0\" marginwidth=\"0\" src=\"https://maps.google.com/maps?q=" + queryString + "&amp;ie=UTF8&amp;hq=&amp;hnear=" + queryString + "&amp;t=m&amp;z=14&amp;output=embed\"></iframe><br /><small><a href=\"https://maps.google.com/maps?q=" + queryString + "&amp;ie=UTF8&amp;hq=&amp;hnear=" + queryString + "&amp;style=\"color:#0000FF;text-align:left\">View Larger Map</a></small>");
}


// send email
function mailTo(address) {
  queryString = 'mailto:' + address;
  location.href=queryString;
}

// send email
function sendEmail(id) {
  email = $("#"+id).val();
  queryString = 'mailto:' + email;
  location.href=queryString;
}

// open URL
function openURL(id) {
  url = $("#"+id).val();
  if (url.substring(0,7) === "http://") {
    queryString = url;
  } else {
    queryString = 'http://' + url;
  }
  window.open(queryString);
}

// modal window

