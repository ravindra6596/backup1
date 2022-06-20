$(document).ready(function() {

	var path = window.location.pathname;
	var page = path.split("/").pop();
	
	$('.datepicker').datepicker({
        autoclose: true,
        format: 'dd-mm-yyyy'
    });
	$('.monthpicker').daterangepicker({
    	locale:{
    		format: "DD-MM-YYYY",
    		viewMode: "months", 
  	      minViewMode: "months",
  	      
    	}
    });
    $('.select2').select2();
    $('.datatable').DataTable();
    $('.fadeout').fadeIn(function () {
	     $(this).delay(2500).fadeOut(1600, function () {});
	 });
    //Timepicker
    $('.timepicker').timepicker({
      showInputs: false,
      showMeridian: false
    });
    //Monthpicker
    $(".monthdatepicker").datepicker( {
        format: "mm-yyyy",
        viewMode: "months", 
        minViewMode: "months"
    });
    
    //Add Employee
    if($('#addEmployee_datepicker1').length > 0){
	    $('#addEmployee_datepicker1').on('change', function() {
			var birthDay = document.getElementById("addEmployee_datepicker1").value;
			var DOB = new Date(birthDay);
			var today = new Date();
			var age = today.getTime() - DOB.getTime();
			age = Math.floor(age / (1000 * 60 * 60 * 24 * 365.25));
			document.getElementById('addEmployee_age').value = age;
		});
	}
	
	
	if($("#hiddenChartData input[name=chartdata]").length > 0){
		//Home Dashboard
	
		var chartdata = $("#hiddenChartData input[name=chartdata]").val();
		cdataJson = JSON.parse(chartdata);
		
		var MONTHS = [];
		var data = [];
		var targets = [];
		$.each(cdataJson, function(k, v){
			t = JSON.parse(v);
			MONTHS.push(moment(t.y).format("MMM-Y"));
			data.push(t.item1);
			targets.push(t.item2);
		});
		
		// Bar chart
		new Chart(document.getElementById("bar-chart"), {
		    type: 'bar',
		    data: {
		      labels: MONTHS,
		      datasets: [
		        {
		          label: "Sale",
		          backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850", "#3E4491", "#C7417B", "#679186", "#FFA822", "#FF6150", "#1AC0C6", "#95ADBE"],
		          data: data
		        },
		        {
		          label: "Target",
		          data: targets
		        }
		      ]
		    },
		    options: {
		      legend: { display: false },
		      title: {
		        display: true,
		        text: 'Sales Over Last 12 Months'
		      }
		    }
		});
	}

	//add doctor-----------------------------------------------------------------------------------------------------------------------------
	if($('#addDoctor_datepicker1').length > 0){
	    $('#addDoctor_datepicker1').on('change', function() {
			var birthDay = document.getElementById("addDoctor_datepicker1").value;
			var DOB = new Date(birthDay);
			var today = new Date();
			var age = today.getTime() - DOB.getTime();
			age = Math.floor(age / (1000 * 60 * 60 * 24 * 365.25));
			document.getElementById('doctors_age').value = age;
		});
	}
	//-------------------------------------------------------------------------------------------------------------------------------------------
	if (page == 'Admin/addnewdoctor.jsp' || page == 'Admin/singledoctor.jsp') {
		//add Doctor
		
		
		var addButton = $('.add_schedule'); //Add button selector
		var wrapper = $('.schedule_wrapper'); //Input field wrapper
		var i = 0;

		//New input field html 
		var x = 1; //Initial field counter is 1

		//Once add button is clicked
		$('.add_schedule').click(function() {
			alert("add more");
			var fieldHTML = '<div class="row" data-sel-sr="1"><div class="col-md-4"><div class="form-group"><label>Select CallWeek</label><select class="form-control" style="width: 100%;" name="callweek[]"><option selected="selected" disabled="disabled">selec	Week</option><option value="1">1st Week</option><option value="2">2nd Week</option><option value="3">3rd Week</option><option value="4">4th Week</option><option value="everyweek">Every Week</option></select></div></div><div class="col-md-4"><div class="form-group"><label>Select Call Day</label><select class="form-control" style="width: 100%;" name="callday[]"><option selected="selected" disabled="disabled">select Day</option><option value="1">Monday</option><option value="2">Tuesday</option><option value="3">Wednesday</option><option value="4">Thursday</option><option value="5">Friday</option><option value="6">Saturday</option><option value="everday">Every Day</option></select></div></div><div class="col-md-2" style="margin-top: 24px;"><a href="javascript:void(0);" class="btn btn-primary remove_schedule">Remove</a></div></div>';

			x++; //Increment field counter
			$(wrapper).append(fieldHTML); //Add field html

			var $select = $('.field_wrapper > .row:nth-child(' + x + ') #callweek_select').select2();
		});
		//Once remove button is clicked
		$(wrapper).on('click', '.remove_schedule', function(e) {
			e.preventDefault();
			$(this).parent().parent('div').remove(); //Remove field html
			x--; //Decrement field counter
		});
	}else if (page == 'Admin/compilationProducts.jsp') {
		$('#select_area').on('change', function() {
			var aid = $(this).val();
			$.ajax({
				method : "Post",
				url : window.location.pathname.substring(0, window.location.pathname.indexOf("/",2))+"/CompilationProducts",
				data : {
					submit : "filterdoc",
					aid : aid
				},
				success : function(result) {
					result = result.substr(37);
					var json = JSON.parse(result);
					var arr_names = json.name;
					var arr_ids = json.ids;
					
					var $select = $('#selectDoc_compilePro');
					// save current config. options
					var options = $select.data('select2').options.options;

					// delete all items of the native select element
					$select.html('');

					// build new items
					var items = [];
					console.log(arr_names.length);
					console.log(arr_ids.lenth);
					$select.append("<option selected='selected' disabled='disabled' >Select Stokiest</option>");
					for (var i = 0; i < arr_names.length; i++) {
						for (var j = 0; j < arr_ids.length; j++) {
							if (i == j) {

								items.push({
									"id" : arr_ids[i],
									"text" : arr_names[i]
								});

								$select.append("<option value='" + arr_ids[j] + "'>" + arr_names[i] + "</option>");
							}
						}
					}
					// add new items
					options.data = items;
					$select.select2(options);
				},
				error : function(response, status, xhr) {
					if (status == "error") {
						var msg = "Sorry but there was an error: ";
						alert(msg + xhr.status + " " + xhr.statusText);
					}
				}
			})

		});
	} else if(page == 'Admin/addArea.jsp'){
		 $('#selected_hq').on('change', function(){
			var hid = $(this).val();
			$.ajax({
				 url:"ajaxcall.jsp",
				 data: {hid : hid},
				 method: "POST",
				 success: function(result){
					
					 var json = JSON.parse(result);
					 var arr_names = json.areaname;
			 			var arr_ids = json.aid;
			 			console.log(arr_ids); console.log(arr_names);
			 			var $select = $('.add_areasecond');

			 		// save current config. options
			 		var options = $select.data('select2').options.options;

			 		// delete all items of the native select element
			 		$select.html('');

			 		// build new items
			 		var items = [];
			 		console.log(arr_names.length);
			 		console.log(arr_ids.lenth);
			 		$select.append("<option selected='selected' disabled='disabled' >Select Area</option>");
			 		for (var i = 0; i <arr_names.length; i++) {
			 		  for(var j = 0; j<arr_ids.length;j++){
			 			 if(i==j){
			 				 
				 		    items.push({
				 		        "id": arr_ids[i],
				 		        "text": arr_names[i]
				 		    });
			
				 		    $select.append("<option value='" +arr_ids[j] + "'>" + arr_names[i] + "</option>");
			 				}
			 		 	 }
			 		}
			 		// add new items
			 		options.data = items;
			 		$select.select2(options);
				 },
				 error: function(response, status, xhr){
		 			 if ( status == "error" ) {
		 			    var msg = "Sorry but there was an error: ";
		 			    alert(msg + xhr.status + " " + xhr.statusText);
		 			  }
		 		}
			});
		 });
		 
		 
	}
});

$("#first-select").change(function() {
	var area = $('#first-select').val();

	$.ajax({
		method : 'POST',
		url : "Admin/ajaxcall.jsp",
		data : {
			area : area
		},
		success : function(result) {
			alert(result);
			var arr = [];
			arr = result.split("-");
			var arr_valDoctorId = [];
			arr_valDoctorId = arr[0].replace(/[\[\]]/g, "").split(",");
			var arr_valDoctorName = [];
			arr_valDoctorName = arr[1].replace(/[\[\]]/g, "").split(",");
			var $select = $('#second-select');

			// save current config. options
			var options = $select.data('select2').options.options;

			// delete all items of the native select element
			$select.html('');

			// build new items
			var items = [];
			var values = [];
			$select.append("<option selected='selected' disabled='disabled' >Select Doctors</option>");
			for (var i = 0; i < arr_valDoctorName.length; i++) {
				for (var j = 0; j < arr_valDoctorId.length; j++) {
					// logik to create new items

					if (i == j) {
						items.push({
							"id" : arr_valDoctorName[i],
							"text" : arr_valDoctorName[i]
						});


						$select.append("<option value='" + arr_valDoctorId[j] + "'>" + arr_valDoctorName[i] + "</option>");
					}
				}
			}

			// add new items
			options.data = items;
			//options.values = items;s
			$select.select2(options);
		},
		error : function(response, status, xhr) {
			if (status == "error") {
				var msg = "Sorry but there was an error: ";
				alert(msg + xhr.status + " " + xhr.statusText);
			}
		}
	});
});
$("#second-select").change(function() {
	var doctor = $('#second-select').val();
	//alert(doctor);
	$.ajax({
		method : 'POST',
		url : "ajaxcall.jsp",
		data : {
			doctor : doctor
		},
		success : function(result) {
			alert(result);
			var arr = [];
			arr = result.split("-");
			var arr_CampId = [];
			arr_CampId = arr[0].replace(/[\[\]]/g, "").split(",");
			var arr_CampName = [];
			arr_CampName = arr[1].replace(/[\[\]]/g, "").split(",");

			var $select = $('#campaign-select');

			// save current config. options
			var options = $select.data('select2').options.options;

			// delete all items of the native select element
			$select.html('');

			// build new items
			var items = [];

			$select.append("<option selected='selected' disabled='disabled' >Select Campaign</option>");
			for (var i = 0; i < arr_CampName.length; i++) {
				for (var j = 0; j < arr_CampId.length; j++) {
					// logik to create new items

					if (i == j) {
						// logik to create new items


						items.push({
							"id" : arr[i],
							"text" : arr[i]
						});

						$select.append("<option value='" + arr_CampId[j] + "'>" + arr_CampName[i] + "</option>");
					}
				}
			}

			// add new items
			options.data = items;
			$select.select2(options);
		},
		error : function(response, status, xhr) {
			if (status == "error") {
				var msg = "Sorry but there was an error: ";
				alert(msg + xhr.status + " " + xhr.statusText);
			}
		}
	});
});


function toggle_edit() {
	if ($('#box1').css('display') == 'block' || $('#toggle_button').css('display') == 'block') {
		$('#box1').css("display", "none");
		$('#box2').css('display', 'block');
		$('#toggle_button').css('display', 'none');
		$('#toggle_button_2').css('display', 'block');
	} else {
		$('#box1').css('display', 'block');
		$('#box2').css('display', 'none');
		$('#toggle_button').css('display', 'block');
		$('#toggle_button_2').css('display', 'none');
	}

}

function toggle_select(ele) {
	$('#doctorsList').html("  <option selected>Select Doctor</option>");
	
	$.ajax({
	    type: 'POST',
	    url: "GenerateTP",
	    data: {eid : ele.value, flag:'fetchDoctors' },
	    success: function(resultData) 
	    { 
	    
	    	console.log(resultData)
	    	
	    	var options = JSON.parse(resultData);
	    	$.each(options, function(key, value) {   
	    	     $('#doctorsList')
	    	         .append($("<option ></option>")
	    	                    .attr("value", value["did"])
	    	                    .text(value["name"])); 
	    	});
	    	
	    } ,
	    
	    error: function(jqXHR,error, errorThrown) {   }
	});
	
	
	
	
	
	
	
	
	
	
	
	
	
	//Newly addded from footer.jsp	
	
	
	$('#leaveAdminDashboard').DataTable()
	$('#example2').DataTable({
		'paging'      : true,
	   	'lengthChange': false,
	    'searching'   : false,
	    'ordering'    : true,
	    'info'        : true,
	    'scrollX': true
	});
	

   
    //manual tourplan timepicker
    
    $('.manualtimepicker').timepicker({
    	showMeridian: false
    })
    
    $('.flat-red').iCheck({
      checkboxClass: 'icheckbox_square-blue',
      radioClass: 'iradio_square-blue',
      increaseArea: '20%' /* optional */
    });
    
    
    //Initialize Select2 Elements
    
    
    $('.select2_assigndoctor').select2().on('change', function(){
    	var eid = this.value;
    	$.ajax({
    		type: "POST",
    		url : window.location.pathname.substring(0, window.location.pathname.indexOf("/",2))+'/AssignDoctor',
    		data : {submit : 'search_area',
    				eid : eid 
    				},
    		success: function(result){
    			console.log(result);
    			result_without_path = result.substr(37);
    			alert(result_without_path);
    			if(result_without_path == "select area"){
    				$('#assign_doctor_area').css('display', 'block');
    			}
    		},
    		error: function(){
    			alert("error");
    		}
    	})
    })

    //Datemask dd/mm/yyyy
    $('#datemask').inputmask('dd/mm/yyyy', { 'placeholder': 'dd/mm/yyyy' })
    //Datemask2 mm/dd/yyyy
    $('#datemask2').inputmask('mm/dd/yyyy', { 'placeholder': 'mm/dd/yyyy' })
    //Money Euro
    $('[data-mask]').inputmask()

    //Date range picker
    $('#reservation').daterangepicker({
    	locale:{
    		format: "YYYY-MM-DD",
    		viewMode: "months", 
  	      minViewMode: "months",
  	      
    	}
    });
    
   
    $('#productSale_reservation').daterangepicker({
    	locale:{
    		format: "YYYY-MM-DD",
    		viewMode: "months", 
  	      minViewMode: "months",
  	      
    	}
    });
    
    $('#campaignSale_reservation').daterangepicker({
    	locale:{
    		format: "YYYY-MM",
    		viewMode: "months", 
  	      minViewMode: "months",
  	      autoclose: true
    	}
    });
    
    $('#reservation_abcstat').daterangepicker({
    	locale:{
    		format: "YYYY-MM",
    		viewMode: "months", 
  	      minViewMode: "months",
  	      autoclose: true
    	}
    });
    
    $('#samplereport_daterange').daterangepicker({
    	locale:{
    		format: "YYYY-MM-DD",
    		viewMode: "months", 
  	      minViewMode: "months",
  	      autoclose: true
    	}
    });
    
    $('#daterange_employeeMonthWiseReport').daterangepicker({
    	locale:{
    		format: "YYYY-MM-DD",
    		viewMode: "months", 
  	      minViewMode: "months",
  	      autoclose: true
    	}
    });
    
    
    
    $('#reservation1').daterangepicker()
    //Date range picker with time picker
    $('#reservationtime').daterangepicker({ timePicker: true, timePickerIncrement: 30, format: 'MM/DD/YYYY h:mm A' })
    //Date range as a button
    $('#daterange-btn').daterangepicker(
      {
        ranges   : {
          'Today'       : [moment(), moment()],
          'Yesterday'   : [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
          'Last 7 Days' : [moment().subtract(6, 'days'), moment()],
          'Last 30 Days': [moment().subtract(29, 'days'), moment()],
          'This Month'  : [moment().startOf('month'), moment().endOf('month')],
          'Last Month'  : [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
        },
        startDate: moment().subtract(29, 'days'),
        endDate  : moment()
      },
      function (start, end) {
        $('#daterange-btn span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'))
      }
    )

    //Date picker
    $('#datepicker').datepicker({
    	format : "yyyy-mm",
	        viewMode: "months", 
	      minViewMode: "months",
      autoclose: true
    });
    
    $('#datepicker1').datepicker({
    	format: "yyyy-mm-dd",
        autoclose: true
      });
      
    //manual_tourplan
    $('#manualtourplan_datepicker').datepicker({
    	format: 'yyyy-mm-dd',
    	autoclose:true,
    	
    });
    
    //update EMployee
    
    $('#updateEmployee_datepicker2').datepicker({
        autoclose: true,
        format: 'yyyy-mm-dd'
      });
    
    //target
     $('#reservation_individualTarget').datepicker({
    		format: "yyyy-mm",
    		viewMode: "months",
    		minViewMode: "months",
    		autoclose: true
    });
    
    $('#brandtrend_datepicker').datepicker({
    	format : 'yyyy',
    	viewMode: "years",
    	minViewMode: "years",
    	autoclose: true
    })
    
    
    //update Doctor
    $('#updateDoctor_datepicker').datepicker({
        autoclose: true,
        format: 'yyyy-mm-dd'
      });
    $('#updateDoctor_datepicker2').datepicker({
        autoclose: true,
        format: 'yyyy-mm-dd'
      });
    
    
    //all Campaign
    $('#allcamp_datepicker1').datepicker({
        autoclose: true
      });
    $('#allcamp_datepicker2').datepicker({
        autoclose: true
      });
    
    //add campaign
    
     $('#CampaignInformation_datepicker1').datepicker({
      autoclose: true,
      format:'yyyy-mm-dd'
    });
    
     $('#CampaignInformation_datepicker2').datepicker({
         format: 'yyyy-mm-dd',
     	autoclose: true
       });
    
   	 //add stockiest
   	 $('#addStockiest_datepicker').datepicker({
   		 autoclose: true
   	 })
    	//update stockiest
    	$('#updateStockiest_datepicker1').datepicker({
    		format: 'yyyy-mm-dd',
   		 autoclose: true
   	 })
    	
   	//
   		$('#datepicker_employeeMonthWiseReport').datepicker({
    		format: 'yyyy-mm',
    		viewMode: "months", 
  	      minViewMode: "months",
   		 autoclose: true
   	 })
   	
   	 //Primary Sale
   	 $('#primarySale_datepicker').datepicker({
    		format: 'yyyy-mm-dd',
   		    autoclose: true
   	 })
   	 
    //iCheck for checkbox and radio inputs
    $('input[type="checkbox"].minimal, input[type="radio"].minimal').iCheck({
      checkboxClass: 'icheckbox_minimal-blue',
      radioClass   : 'iradio_minimal-blue'
    })
    //Red color scheme for iCheck
    $('input[type="checkbox"].minimal-red, input[type="radio"].minimal-red').iCheck({
      checkboxClass: 'icheckbox_minimal-red',
      radioClass   : 'iradio_minimal-red'
    })
    //Flat red color scheme for iCheck
    $('input[type="checkbox"].flat-red, input[type="radio"].flat-red').iCheck({
      checkboxClass: 'icheckbox_flat-green',
      radioClass   : 'iradio_flat-green'
    })
	
	
	var path = window.location.href; // because the 'href' property of the DOM element is the absolute path
    $('li a').each(function() {
    	if(this.href === path) {
    		$(this).closest("li").addClass("active"); 
    		$(this).parents("li").addClass("active");
    	}
    });

	var addButton = $('.add_button'); //Add button selector
	var wrapper = $('.field_wrapper'); //Input field wrapper
	var i=0;
	
		 //New input field html 
	var x = 1; //Initial field counter is 1
	
	//Once add button is clicked
	$(addButton).click(function(){
			var selHTML = $(this).closest('.row').find('select').html();
			var fieldHTML = '<div class="row" data-sel-sr="1"><div class="col-md-3"><div class="form-group"><label>Select Product</label><select class="form-control" style="width: 100%;" name="pname[]">'+selHTML+'</select></div></div><div class="col-md-3"><div class="form-group"><label>Quantity</label><input type="number" class="form-control" placeholder="Quantity" name="targetqty[]"></div></div><div class="col-md-2" style="margin-top: 24px;"><a href="javascript:void(0);" class="btn btn-primary remove_button">Remove</a></div></div>';
	
	        x++; //Increment field counter
	        $(wrapper).append(fieldHTML); //Add field html
	        
	        var $select = $('.field_wrapper > .row:nth-child('+x+') select').select2();
	});
	
	//Add_more from place order page
	$('.add_more').click(function(){
			var selHTML = $(this).closest('.row').find('select').html();
			var fieldHTML = '<div class="row" data-sel-sr="1"><div class="col-md-4"><div class="form-group"><label>Select Product</label><select class="form-control" style="width: 100%;" name="pname[]">'+selHTML+'</select></div></div><div class="col-md-4"><div class="form-group"><label>Quantity</label><input type="number" class="form-control" placeholder="Quantity" name="targetqty[]"></div></div><div class="col-md-2" style="margin-top: 24px;"><a href="javascript:void(0);" class="btn btn-primary remove_button">Remove</a></div></div>';
	
	        x++; //Increment field counter
	        $(wrapper).append(fieldHTML); //Add field html
	        
	        var $select = $('.field_wrapper > .row:nth-child('+x+') select').select2();
	});
	
	$('.add_more_sample').click(function(){
		var selHTML = $(this).closest('.row').find('select').html();
		var fieldHTML = '<div class="row" data-sel-sr="1"><div class="col-md-5"><div class="form-group"><label>Select Product</label><select class="form-control" style="width: 100%;" name="pname[]">'+selHTML+'</select></div></div><div class="col-md-5"><div class="form-group"><label>Quantity</label><input type="number" class="form-control" placeholder="Quantity" name="targetqty[]"></div></div><div class="col-md-2" style="margin-top: 24px;"><a href="javascript:void(0);" class="btn btn-primary remove_button">Remove</a></div></div>';
	
	    x++; //Increment field counter
	    $(wrapper).append(fieldHTML); //Add field html
	    
	    var $select = $('.field_wrapper > .row:nth-child('+x+') select').select2();
	});
	
	//Once remove button is clicked
	$(wrapper).on('click', '.remove_button', function(e){
	    e.preventDefault();
	    $(this).parent().parent('div').remove(); //Remove field html
	    x--; //Decrement field counter
	}); 
	
	
	var startDate = new Date();
	var fechaFin = new Date();
	var FromEndDate = new Date();
	var ToEndDate = new Date();
	 
	 $('.from').datepicker({
	    autoclose: true,
	    minViewMode: 1,
	    format: 'yyyy-mm'
	}).on('changeDate', function(selected){
	        startDate = new Date(selected.date.valueOf());
	        startDate.setDate(startDate.getDate(new Date(selected.date.valueOf())));
	        $('.to').datepicker('setStartDate', startDate);
	    }); 
	
	 
	 
	 
	 
}



function isNumberKey(evt){
	var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57))
        return false;
    return true;
}

function isAmount(origEle, evt){
	var charCode = (evt.which) ? evt.which : evt.keyCode;
	
	if(charCode == 46)
		return origEle.value.indexOf('.') != -1 ? false : true;
	else
		return isNumberKey(evt);	
}