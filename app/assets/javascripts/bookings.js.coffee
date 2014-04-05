jQuery ->
	$('#calendar').fullCalendar(
		defaultView: 'agendaWeek',
		events:'bookings.json'
		)
