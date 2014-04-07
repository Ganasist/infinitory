json.array!(@bookings) do |booking|
  json.extract! 	 booking, :id
  json.title			 booking.device.fullname
  json.description booking.duration
  json.start 			 booking.start_time
  json.end	 			 booking.end_time
  json.allDay			 booking.all_day
  # json.url			 "www.google.com"
end