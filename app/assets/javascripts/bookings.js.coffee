jQuery ->
	$('#calendar').fullCalendar
		defaultView: 'agendaWeek'
		events:'bookings.json'
		allDayDefault: false
		firstHour: 8
		firstDay: 1
		columnFormat: { week: 'ddd d/M' }
		timeFormat: 'H:mm{ - H:mm}'
		axisFormat: 'H:mm{ - H:mm}'
		height: 650

		# eventRender: (event, element) ->
		# 	element.popover
		# 	alert('event.name')
		    # title: event.name
		    # placement: "right"
		    # content: +"<br />Start: " + event.starts_at + "<br />End: " + event.ends_at + "<br />Description: " + event.description

		# eventClick: (calEvent, jsEvent, view) ->
		# 	console.log('User: ' + calEvent.member)

		eventMouseover: (calEvent, jsEvent, view) ->
			console.log('Device: ' + calEvent.title)
			calEvent.popover
		    title: calEvent.title
		    placement: "right"
		    content: +"<br />Start: " + calEvent.title + "<br />End: " + calEvent.title + "<br />Description: " + calEvent.title

	$('#calendar_edit').fullCalendar
		defaultView: 'agendaWeek'
		events:'edit.json'
		allDayDefault: false
		firstHour: 8
		firstDay: 1
		columnFormat: { week: 'ddd d/M' }
		timeFormat: 'H:mm{ - H:mm}'
		axisFormat: 'H:mm{ - H:mm}'
		height: 650

	$('#calendar_new').fullCalendar
		defaultView: 'agendaWeek'
		events:'new.json'
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


