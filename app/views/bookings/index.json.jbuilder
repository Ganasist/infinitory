json.array! @calendar_data do |booking|
  json.extract! 	 booking, :id
  json.title			 booking.device.fullname if params[:user_id]
	json.title			 booking.user.fullname if params[:device_id]
  json.start 			 booking.start_time
  json.end	 			 booking.end_time
  json.allDay			 booking.all_day
end