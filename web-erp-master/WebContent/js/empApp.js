/**
 * 
 */

$(document)
		.ready(
				function() {
					var path = window.location.pathname;
					var page = path.split("/").pop();
					if (page == 'empDashboard.jsp') {
						/* ABM Team Target chart */

						// -------------
						// - BAR CHART -
						// -------------
						var productData = $(
								"#hiddenCalenderData input[name=Product_Data]")
								.val();
						var targetData = $(
								"#hiddenCalenderData input[name=target_Data]")
								.val();
						var acheivedData = $(
								"#hiddenCalenderData input[name=acheived_Data]")
								.val();

						var proArray = [];
						proArray = productData.split(",");
						var targetArray = targetData.split(",");
						var acheivedArray = acheivedData.split(",");

						var barChartData = {
							labels : proArray,
							datasets : [ {
								label : 'Products',
								fillColor : 'rgba(210, 214, 222, 1)',
								strokeColor : 'rgba(210, 214, 222, 1)',
								pointColor : 'rgba(210, 214, 222, 1)',
								pointStrokeColor : '#c1c7d1',
								pointHighlightFill : '#fff',
								pointHighlightStroke : 'rgba(220,220,220,1)',
								data : targetArray
							}, {
								label : 'Quantity',
								fillColor : 'rgba(60,141,188,0.9)',
								strokeColor : 'rgba(60,141,188,0.8)',
								pointColor : '#3b8bba',
								pointStrokeColor : 'rgba(60,141,188,1)',
								pointHighlightFill : '#fff',
								pointHighlightStroke : 'rgba(60,141,188,1)',
								data : acheivedArray
							} ]
						}

						var barChartCanvas = $('#barChart').get(0).getContext(
								'2d')
						var barChart = new Chart(barChartCanvas)
						var barChartData = barChartData
						barChartData.datasets[1].fillColor = '#00a65a'
						barChartData.datasets[1].strokeColor = '#00a65a'
						barChartData.datasets[1].pointColor = '#00a65a'
						var barChartOptions = {
							// Boolean - Whether the scale should start at zero,
							// or an order of magnitude down from the lowest
							// value
							scaleBeginAtZero : true,
							// Boolean - Whether grid lines are shown across the
							// chart
							scaleShowGridLines : true,
							// String - Colour of the grid lines
							scaleGridLineColor : 'rgba(0,0,0,.05)',
							// Number - Width of the grid lines
							scaleGridLineWidth : 1,
							// Boolean - Whether to show horizontal lines
							// (except X axis)
							scaleShowHorizontalLines : true,
							// Boolean - Whether to show vertical lines (except
							// Y axis)
							scaleShowVerticalLines : true,
							// Boolean - If there is a stroke on each bar
							barShowStroke : true,
							// Number - Pixel width of the bar stroke
							barStrokeWidth : 2,
							// Number - Spacing between each of the X value sets
							barValueSpacing : 5,
							// Number - Spacing between data sets within X
							// values
							barDatasetSpacing : 1,

							// Boolean - whether to make the chart responsive
							responsive : true,
							maintainAspectRatio : true
						}

						barChartOptions.datasetFill = false
						barChart.Bar(barChartData, barChartOptions)

						// --------------
						// - AREA CHART -
						// --------------

						var SaleAmount = $(
								"#hiddenCalenderData input[name=PersonalSale_totalAmt]")
								.val();
						var Year_month = $(
								"#hiddenCalenderData input[name=PersonalSale_year_month]")
								.val();

						var saleAmt_Array = SaleAmount.split(",");
						var yrMnth_Array = Year_month.split(",");
						// Get context with jQuery - using jQuery's .get()
						// method.
						var areaChartCanvas = $('#areaChart').get(0)
								.getContext('2d')
						// This will get the first returned node in the jQuery
						// collection.
						var areaChart = new Chart(areaChartCanvas)

						var areaChartData = {
							labels : yrMnth_Array,
							datasets : [

							{
								label : 'Digital Goods',
								fillColor : 'rgba(60,141,188,0.9)',
								strokeColor : 'rgba(60,141,188,0.8)',
								pointColor : '#3b8bba',
								pointStrokeColor : 'rgba(60,141,188,1)',
								pointHighlightFill : '#fff',
								pointHighlightStroke : 'rgba(60,141,188,1)',
								data : saleAmt_Array
							} ]
						}

						var areaChartOptions = {
							// Boolean - If we should show the scale at all
							showScale : true,
							// Boolean - Whether grid lines are shown across the
							// chart
							scaleShowGridLines : false,
							// String - Colour of the grid lines
							scaleGridLineColor : 'rgba(0,0,0,.05)',
							// Number - Width of the grid lines
							scaleGridLineWidth : 1,
							// Boolean - Whether to show horizontal lines
							// (except X axis)
							scaleShowHorizontalLines : true,
							// Boolean - Whether to show vertical lines (except
							// Y axis)
							scaleShowVerticalLines : true,
							// Boolean - Whether the line is curved between
							// points
							bezierCurve : true,
							// Number - Tension of the bezier curve between
							// points
							bezierCurveTension : 0.3,
							// Boolean - Whether to show a dot for each point
							pointDot : false,
							// Number - Radius of each point dot in pixels
							pointDotRadius : 4,
							// Number - Pixel width of point dot stroke
							pointDotStrokeWidth : 1,
							// Number - amount extra to add to the radius to
							// cater for hit detection outside the drawn point
							pointHitDetectionRadius : 20,
							// Boolean - Whether to show a stroke for datasets
							datasetStroke : true,
							// Number - Pixel width of dataset stroke
							datasetStrokeWidth : 2,
							// Boolean - Whether to fill the dataset with a
							// color
							datasetFill : true,
							// String - A legend template
							legendTemplate : '<ul class="<%=name.toLowerCase()%>-legend"><% for (var i=0; i<datasets.length; i++){%><li><span style="background-color:<%=datasets[i].lineColor%>"></span><%if(datasets[i].label){%><%=datasets[i].label%><%}%></li><%}%></ul>',
							// Boolean - whether to maintain the starting aspect
							// ratio or not when responsive, if set to false,
							// will take up entire container
							maintainAspectRatio : true,
							// Boolean - whether to make the chart responsive to
							// window resizing
							responsive : true
						}

						// Create the line chart
						areaChart.Line(areaChartData, areaChartOptions)
						
						/* initialize the calendar
						 -----------------------------------------------------------------*/
						 //Date for the calendar events (dummy data)
						 
						 
						 
						 var calendardata = $("#hiddenCalenderData input[name=calenderdata]").val();
						 
						 cdataJson = JSON.parse(calendardata);
						 var charArray = cdataJson;
						 console.log(charArray);
						 
						 var date = new Date()
						 var d    = date.getDate(),
						    m    = date.getMonth(),
						    y    = date.getFullYear()
						    
						 $('#calendar').fullCalendar({
						  header    : {
						    left  : 'prev,next today',
						    center: 'title',
						    right : 'month,agendaWeek,agendaDay'
						  },
						  buttonText: {
						    today: 'today',
						    month: 'month',
						    week : 'week',
						    day  : 'day'
						  },
						  events    :charArray,
						      editable  : true
						      
						 });
						 
						 
						 

					} else if (page == 'leaves.jsp') {
						$("#leave_type")
								.change(
										function() {
											var str = this.value;
											alert(str);
											if (str == "CL") {
												document.getElementById("pid").style.display = "none";
												document.getElementById("sid").style.display = "none";
												document.getElementById("cid").style.display = "inline";
												$('#CL_from_datepicker')
														.datepicker(
																{
																	dateformat : 'YYYY-MM-DD',
																	autoclose : true,
																	endDate : '+1y'
																});
												$('#CL_to_datepicker')
														.datepicker(
																{
																	dateformat : 'YYYY-MM-DD',
																	autoclose : true,
																	endDate : '+1y'
																})
											} else if (str == "PL") {
												document.getElementById("pid").style.display = "inline";
												document.getElementById("sid").style.display = "none";
												document.getElementById("cid").style.display = "none";
												$('#PL_from_datepicker')
														.datepicker({
															autoclose : true,
															startDate : '+1m',
														})
														.on(
																'changeDate',
																function(
																		selected) {

																	var minDate = new Date(
																			selected.date
																					.valueOf());
																	$(
																			'#PL_to_datepicker')
																			.datepicker(
																					'setStartDate',
																					minDate);
																})
											} else if (str == "SL") {
												document.getElementById("pid").style.display = "none";
												document.getElementById("sid").style.display = "inline";
												document.getElementById("cid").style.display = "none";
												$('#SL_from_datepicker')
														.datepicker({

															autoclose : true
														})
														.on(
																'changeDate',
																function(
																		selected) {
																	var minDate = new Date(
																			selected.date
																					.valueOf());
																	$(
																			'#SL_to_datepicker')
																			.datepicker(
																					'setStartDate',
																					minDate);
																});

												$("#SL_to_datepicker")
														.datepicker()
														.on(
																'changeDate',
																function(
																		selected) {

																	var start = $(
																			'#SL_from_datepicker')
																			.val();
																	var end = $(
																			'#SL_to_datepicker')
																			.val();
																	var startD = new Date(
																			start);
																	var endD = new Date(
																			end);
																	var diff = parseInt((endD
																			.getTime() - startD
																			.getTime())
																			/ (24 * 3600 * 1000));
																	if (diff > 2) {
																		alert("please Upload the document");
																		$(
																				'.leave_upload_document')
																				.css(
																						'display',
																						'block');
																	} else {
																		alert("get Well Soon");
																	}
																})

											}
										});
					} else if (page == 'addscheme.jsp') {
						// Add_more from addScheme page
						$('.add_more_Scheme')
								.click(
										function() {
											var selHTML = $(this).closest(
													'.row').find('select')
													.html();
											var fieldHTML = '<div class="row" data-sel-sr="1"><div class="col-md-4"><div class="form-group"><label>Select Product</label><select class="form-control" style="width: 100%;" name="pname[]">'
													+ selHTML
													+ '</select></div></div><div class="col-md-4"><div class="form-group"><label>Scheme</label><input type="text" class="form-control" placeholder="Scheme" name="scheme[]"></div></div><div class="col-md-2" style="margin-top: 24px;"><a href="javascript:void(0);" class="btn btn-primary remove_button">Remove</a></div></div>';

											x++; // Increment field counter
											$(wrapper).append(fieldHTML); // Add
																			// field
																			// html

											var $select = $(
													'.field_wrapper > .row:nth-child('
															+ x + ') select')
													.select2();
										});

						// Once remove button is clicked
						$(wrapper).on('click', '.remove_button', function(e) {
							e.preventDefault();
							$(this).parent().parent('div').remove(); // Remove
																		// field
																		// html
							x--; // Decrement field counter
						});

					}
				});

function toggle_edit() {

	if ($('#box1').css('display') == 'block'
			|| $('#toggle_button').css('display') == 'block') {
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

function generateTp_feedback(status, id) {
	var generate_div = '#generateTp_feedback_' + id;
	var buttons_div = '#generateTp_buttons_' + id;
	if ($(generate_div).css('display') == 'none'
			|| $(buttons_div).css('display') == 'block') {
		$(generate_div).css("display", "block");
		$(buttons_div).css("display", "none");
		$('<input type="hidden" name="status" value="' + status + '">')
				.appendTo(generate_div);
	}
}

function generateTp_feedback_cancel(id) {
	var generate_div = '#generateTp_feedback_' + id;
	var buttons_div = '#generateTp_buttons_' + id;
	if ($(generate_div).css('display') == 'block'
			|| $(buttons_div).css('display') == 'none') {
		$(generate_div).css("display", "none");
		$(buttons_div).css("display", "block");
	}
}