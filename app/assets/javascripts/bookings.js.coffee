jQuery ->
	$('#calendar').fullCalendar
		defaultView: 'agendaWeek'
		events:'bookings.json'
		theme: true
		allDayDefault: false

	$('#datetimepicker_start').datetimepicker
		minDate: 0
		step: 30
		
	$('#datetimepicker_end').datetimepicker
		minDate: 0
		step: 30
