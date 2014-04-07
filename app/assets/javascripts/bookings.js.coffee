jQuery ->
	$('#calendar').fullCalendar(
		weekends: false,
		defaultView: 'agendaWeek',
		events:'bookings.json'
		)
