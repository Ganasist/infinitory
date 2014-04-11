json.array! @bookings do |booking|
  json.extract! 	 booking, :id
  json.title			 booking.user.fullname
  json.start 			 booking.start_time
  json.end	 			 booking.end_time
  json.allDay			 booking.all_day
end