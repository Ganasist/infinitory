jQuery ->
	$('#calendar').fullCalendar
		events:'bookings.json'
		defaultView: 'agendaWeek'
		allDayDefault: false
		firstHour: 8
		firstDay: 1
		columnFormat: { week: 'ddd d/M' }
		timeFormat: 'H:mm{ - H:mm}'
		axisFormat: 'H:mm{ - H:mm}'
		height: 650

	$('#calendar_edit').fullCalendar
		events:'edit.json'
		defaultView: 'agendaWeek'
		allDayDefault: false
		firstHour: 8
		firstDay: 1
		columnFormat: { week: 'ddd d/M' }
		timeFormat: 'H:mm{ - H:mm}'
		axisFormat: 'H:mm{ - H:mm}'
		height: 650

	$('#calendar_new').fullCalendar
		events:'new.json'
		defaultView: 'agendaWeek'
		allDayDefault: false
		firstHour: 8
		firstDay: 1
		columnFormat: { week: 'ddd d/M' }
		timeFormat: 'H:mm{ - H:mm}'
		axisFormat: 'H:mm{ - H:mm}'
		height: 650

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
    #   @setOptions minDate: (if $("#datetimepicker_start").val() then $("#datetimepicker_start").val() else false)


