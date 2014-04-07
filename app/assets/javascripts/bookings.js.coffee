jQuery ->
	$('#calendar').fullCalendar(
		defaultView: 'agendaWeek',
		events:'bookings.json',
		theme: true,
		allDayDefault: false
		)
