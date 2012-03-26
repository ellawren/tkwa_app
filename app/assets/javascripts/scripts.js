
// these are currently not used, too many bugs

function changePhase() {
    var phases;
    phases = $('#timesheet_time_entries_attributes_0_phase_number').html();
 
    return $('.project-selector').change(function () {
      var options, project, num;
      num = $(this).attr('id').replace(/[^0-9]/g, '');
      project = $('#timesheet_time_entries_attributes_' + num + '_project_id :selected').text();
      options = $(phases).filter("optgroup[label='" + project + "']").html();
      if (options) {
          $('#timesheet_time_entries_attributes_' + num + '_phase').html(options);
      } else {
          $('#timesheet_time_entries_attributes_' + num + '_phase').empty();
      }
      return end;
 
    });
}





(function() {

  jQuery(function() {
    //var phases;
    //phases = $('#timesheet_time_entries_attributes_0_phase').html();
    //return $('#timesheet_time_entries_attributes_0_project_id').change(function() {
    $('.timesheet-project-select2').change(function() {
      //var options, project, num;
      num = $(this).attr('id').replace(/[^0-9]/g, '');
      alert(num);
      //project = $('#timesheet_time_entries_attributes_0_project_id :selected').text();
      //options = $(phases).filter("optgroup[label='" + project + "']").html();
      //if (options) {
      //  $('#timesheet_time_entries_attributes_0_phase').html(options);
      //} else {
      //  $('#timesheet_time_entries_attributes_0_phase').empty();
      //}
      //return end;
    });
  });

}).call(this);










function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  //$(link).closest(".input").hide();
  $(link).closest(".table-row").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).before(content.replace(regexp, new_id));
  changePhase();
}


$(function() {
		$(".pop").popover({ placement: 'right', animation:true });
		$(".tip").tooltip({ animation: true, placement: 'top', trigger:'hover' });
		$(".tip-bottom").tooltip({ animation: true, placement: 'bottom', trigger:'hover' });
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

// select current on tracking page
$(document).ready(function() {
  $("#phase-10").click(function () {
    if ( $('th.Predesign').hasClass('deactivated') ) {
    } else {
        $( ".Predesign" ).addClass( "gray" ).removeClass( "light" );
        $( ".Schematic" ).removeClass( "gray" ).addClass( "light" );
        $( ".DesignDev" ).removeClass( "gray" ).addClass( "light" );
        $( ".ConstDocs" ).removeClass( "gray" ).addClass( "light" );
        $( ".Bidding" ).removeClass( "gray" ).addClass( "light" );
        $( ".CCA" ).removeClass( "gray" ).addClass( "light" );
        $( ".Interior" ).removeClass( "gray" ).addClass( "light" );
        $( ".Historic" ).removeClass( "gray" ).addClass( "light" );
        $( ".Additional" ).removeClass( "gray" ).addClass( "light" );
        $( ".TotalToDate" ).removeClass( "gray" );
    }
  });
  $("#phase-20").click(function () {
    if ( $('th.Schematic').hasClass('deactivated') ) {
    } else {
        $( ".Predesign" ).removeClass( "gray" ).removeClass( "light" );
        $( ".Schematic" ).addClass( "gray" ).removeClass( "light" );
        $( ".DesignDev" ).removeClass( "gray" ).addClass( "light" );
        $( ".ConstDocs" ).removeClass( "gray" ).addClass( "light" );
        $( ".Bidding" ).removeClass( "gray" ).addClass( "light" );
        $( ".CCA" ).removeClass( "gray" ).addClass( "light" );
        $( ".Interior" ).removeClass( "gray" ).addClass( "light" );
        $( ".Historic" ).removeClass( "gray" ).addClass( "light" );
        $( ".Additional" ).removeClass( "gray" ).addClass( "light" );
        $( ".TotalToDate" ).removeClass( "gray" );
    }
  });
  $("#phase-30").click(function () {
    if ( $('th.DesignDev').hasClass('deactivated') ) {
    } else {
        $( ".Predesign" ).removeClass( "gray" ).removeClass( "light" );
        $( ".Schematic" ).removeClass( "gray" ).removeClass( "light" );
        $( ".DesignDev" ).addClass( "gray" ).removeClass( "light" );
        $( ".ConstDocs" ).removeClass( "gray" ).addClass( "light" );
        $( ".Bidding" ).removeClass( "gray" ).addClass( "light" );
        $( ".CCA" ).removeClass( "gray" ).addClass( "light" );
        $( ".Interior" ).removeClass( "gray" ).addClass( "light" );
        $( ".Historic" ).removeClass( "gray" ).addClass( "light" );
        $( ".Additional" ).removeClass( "gray" ).addClass( "light" );
        $( ".TotalToDate" ).removeClass( "gray" );
    }
  });
  $("#phase-40").click(function () {
    if ( $('th.ConstDocs').hasClass('deactivated') ) {
    } else {
        $( ".Predesign" ).removeClass( "gray" ).removeClass( "light" );
        $( ".Schematic" ).removeClass( "gray" ).removeClass( "light" );
        $( ".DesignDev" ).removeClass( "gray" ).removeClass( "light" );
        $( ".ConstDocs" ).addClass( "gray" ).removeClass( "light" );
        $( ".Bidding" ).removeClass( "gray" ).addClass( "light" );
        $( ".CCA" ).removeClass( "gray" ).addClass( "light" );
        $( ".Interior" ).removeClass( "gray" ).addClass( "light" );
        $( ".Historic" ).removeClass( "gray" ).addClass( "light" );
        $( ".Additional" ).removeClass( "gray" ).addClass( "light" );
        $( ".TotalToDate" ).removeClass( "gray" );
    }
  });
  $("#phase-50").click(function () {
    if ( $('th.Bidding').hasClass('deactivated') ) {
    } else {
        $( ".Predesign" ).removeClass( "gray" ).removeClass( "light" );
        $( ".Schematic" ).removeClass( "gray" ).removeClass( "light" );
        $( ".DesignDev" ).removeClass( "gray" ).removeClass( "light" );
        $( ".ConstDocs" ).removeClass( "gray" ).removeClass( "light" );
        $( ".Bidding" ).addClass( "gray" ).removeClass( "light" );
        $( ".CCA" ).removeClass( "gray" ).addClass( "light" );
        $( ".Interior" ).removeClass( "gray" ).addClass( "light" );
        $( ".Historic" ).removeClass( "gray" ).addClass( "light" );
        $( ".Additional" ).removeClass( "gray" ).addClass( "light" );
        $( ".TotalToDate" ).removeClass( "gray" );
    }
  });
  $("#phase-60").click(function () {
    if ( $('th.CCA').hasClass('deactivated') ) {
    } else {
        $( ".Predesign" ).removeClass( "gray" ).removeClass( "light" );
        $( ".Schematic" ).removeClass( "gray" ).removeClass( "light" );
        $( ".DesignDev" ).removeClass( "gray" ).removeClass( "light" );
        $( ".ConstDocs" ).removeClass( "gray" ).removeClass( "light" );
        $( ".Bidding" ).removeClass( "gray" ).removeClass( "light" );
        $( ".CCA" ).addClass( "gray" ).removeClass( "light" );
        $( ".Interior" ).removeClass( "gray" ).addClass( "light" );
        $( ".Historic" ).removeClass( "gray" ).addClass( "light" );
        $( ".Additional" ).removeClass( "gray" ).addClass( "light" );
        $( ".TotalToDate" ).removeClass( "gray" );
    }
  });
  $("#phase-65").click(function () {
    if ( $('th.Interior').hasClass('deactivated') ) {
    } else {
        $( ".Predesign" ).removeClass( "gray" ).removeClass( "light" );
        $( ".Schematic" ).removeClass( "gray" ).removeClass( "light" );
        $( ".DesignDev" ).removeClass( "gray" ).removeClass( "light" );
        $( ".ConstDocs" ).removeClass( "gray" ).removeClass( "light" );
        $( ".Bidding" ).removeClass( "gray" ).removeClass( "light" );
        $( ".CCA" ).removeClass( "gray" ).removeClass( "light" );
        $( ".Interior" ).addClass( "gray" ).removeClass( "light" );
        $( ".Historic" ).removeClass( "gray" ).addClass( "light" );
        $( ".Additional" ).removeClass( "gray" ).addClass( "light" );
        $( ".TotalToDate" ).removeClass( "gray" );
    }
  });
  $("#phase-68").click(function () {
    if ( $('th.Historic').hasClass('deactivated') ) {
    } else {
        $( ".Predesign" ).removeClass( "gray" ).removeClass( "light" );
        $( ".Schematic" ).removeClass( "gray" ).removeClass( "light" );
        $( ".DesignDev" ).removeClass( "gray" ).removeClass( "light" );
        $( ".ConstDocs" ).removeClass( "gray" ).removeClass( "light" );
        $( ".Bidding" ).removeClass( "gray" ).removeClass( "light" );
        $( ".CCA" ).removeClass( "gray" ).removeClass( "light" );
        $( ".Interior" ).removeClass( "gray" ).removeClass( "light" );
        $( ".Historic" ).addClass( "gray" ).removeClass( "light" );
        $( ".Additional" ).removeClass( "gray" ).addClass( "light" );
        $( ".TotalToDate" ).removeClass( "gray" );
    }
  });
  $("#phase-70").click(function () {
    if ( $('th.Additional').hasClass('deactivated') ) {
    } else {
        $( ".Predesign" ).removeClass( "gray" ).removeClass( "light" );
        $( ".Schematic" ).removeClass( "gray" ).removeClass( "light" );
        $( ".DesignDev" ).removeClass( "gray" ).removeClass( "light" );
        $( ".ConstDocs" ).removeClass( "gray" ).removeClass( "light" );
        $( ".Bidding" ).removeClass( "gray" ).removeClass( "light" );
        $( ".CCA" ).removeClass( "gray" ).removeClass( "light" );
        $( ".Interior" ).removeClass( "gray" ).removeClass( "light" );
        $( ".Historic" ).removeClass( "gray" ).removeClass( "light" );
        $( ".Additional" ).addClass( "gray" ).removeClass( "light" );
        $( ".TotalToDate" ).removeClass( "gray" );
    }
  });

  $("#total").click(function () {
      $( ".Predesign" ).removeClass( "gray" ).removeClass( "light" );
      $( ".Schematic" ).removeClass( "gray" ).removeClass( "light" );
      $( ".DesignDev" ).removeClass( "gray" ).removeClass( "light" );
      $( ".ConstDocs" ).removeClass( "gray" ).removeClass( "light" );
      $( ".Bidding" ).removeClass( "gray" ).removeClass( "light" );
      $( ".CCA" ).removeClass( "gray" ).removeClass( "light" );
      $( ".Interior" ).removeClass( "gray" ).removeClass( "light" );
      $( ".Historic" ).removeClass( "gray" ).removeClass( "light" );
      $( ".Additional" ).removeClass( "gray" ).removeClass( "light" );
      $( ".TotalToDate" ).addClass( "gray" );
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

$(document).ready(function() {

    // Support for AJAX loaded modal window.
    // Focuses on first input textbox after it loads the window.
    $('[datatoggle="modal"]').click(function(e) {
    e.preventDefault();
    var href = $(this).attr('href');
    if (href.indexOf('#') == 0) {
        $(href).modal('open');
    } else {
        $.get(href, function(data) {
        $('<div class="modal fade" >' + data + '</div>').modal();
        })
    }
    });

});


// open map
function openMap(id) {
  address = $("#"+id).text();
  queryString = address.replace(/(\r\n|\n|\r| )/gm,"+");
  window.open('http://maps.google.com/maps?q=' + queryString);
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








	