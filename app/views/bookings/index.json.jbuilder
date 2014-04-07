json.array!(@bookings) do |booking|
  json.extract! booking, :id, :title, :description
  json.start 		booking.start_time
  json.end	 		booking.end_time
  json.allDay		booking.all_day
  # json.url			"www.google.com"
end