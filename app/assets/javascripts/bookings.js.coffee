jQuery ->
	$('#calendar').fullCalendar
		defaultView: 'agendaWeek'
		events:'bookings.json'
		theme: true
		allDayDefault: false
		firstHour: 8
		firstDay: 1
		columnFormat: { week: 'ddd d/M' }

		# eventClick: (calEvent, jsEvent, view) ->
		# 	console.log('User: ' + calEvent.member)

		# eventMouseover: (calEvent, jsEvent, view) ->
		# 	console.log('Device: ' + calEvent.title)

	$('#calendar_edit').fullCalendar
		defaultView: 'agendaWeek'
		events:'edit.json'
		theme: true
		allDayDefault: false
		firstHour: 8
		firstDay: 1
		columnFormat: { week: 'ddd d/M' }

	$('#calendar_new').fullCalendar
		defaultView: 'agendaWeek'
		events:'new.json'
		theme: true
		allDayDefault: false
		firstHour: 8
		firstDay: 1
		columnFormat: { week: 'ddd d/M' }

	$('#datetimepicker_start').datetimepicker
		minDate: 0
		step: 30
		roundTime: 'round'
		# onShow: (ct) ->
		# 	@setOptions maxDate: (if $("#datetimepicker_end").val() then $("#datetimepicker_end").val() else false)

	$('#datetimepicker_end').datetimepicker
		minDate: 0
		step: 30
		roundTime: 'round'
		# onShow: (ct) ->
  #     @setOptions minDate: (if $("#datetimepicker_start").val() then $("#datetimepicker_start").val() else false)