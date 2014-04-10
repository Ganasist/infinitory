jQuery ->
	$('#calendar').fullCalendar
		defaultView: 'agendaWeek'
		events:'bookings.json'
		allDayDefault: false
		firstHour: 8
		firstDay: 1
		columnFormat: { week: 'ddd d/M' }
		timeFormat: 'H:mm{ - H:mm}'

		# eventClick: (calEvent, jsEvent, view) ->
		# 	console.log('User: ' + calEvent.member)

		# eventMouseover: (calEvent, jsEvent, view) ->
		# 	console.log('Device: ' + calEvent.title)

	$('#calendar_edit').fullCalendar
		defaultView: 'agendaWeek'
		events:'edit.json'
		allDayDefault: false
		firstHour: 8
		firstDay: 1
		columnFormat: { week: 'ddd d/M' }
		timeFormat: 'H:mm{ - H:mm}'

	$('#calendar_new').fullCalendar
		defaultView: 'agendaWeek'
		events:'new.json'
		allDayDefault: false
		firstHour: 8
		firstDay: 1
		columnFormat: { week: 'ddd d/M' }
		timeFormat: 'H:mm{ - H:mm}'

	$('#datetimepicker_start').datetimepicker
		minDate: 0
		step: 30
		dayOfWeekStart: 1
		roundTime: 'round'
		# onShow: (ct) ->
		# 	@setOptions maxDate: (if $("#datetimepicker_end").val() then $("#datetimepicker_end").val() else false)

	$('#datetimepicker_end').datetimepicker
		minDate: 0
		step: 30
		dayOfWeekStart: 1
		roundTime: 'round'
		# onShow: (ct) ->
  #     @setOptions minDate: (if $("#datetimepicker_start").val() then $("#datetimepicker_start").val() else false)


