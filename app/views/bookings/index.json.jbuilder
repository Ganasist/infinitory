json.array!(@bookings) do |booking|
  json.extract! booking, :id, :title, :description
  json.start 		booking.start_time
  json.end	 		booking.end_time
  # json.url			"www.google.com"
end