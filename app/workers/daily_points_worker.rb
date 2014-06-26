class DailyPointsWorker

	include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence backfill: true do
    daily
  end
  
  def perform
    today = DateTime.now

    Lab.find_each do |l|
      # Initiate required variables, reset Lab's points each day to zero
      lab_daily_average = 0
      lab_total_points  = 0
      l.subtract_points(l.points)    	
      # Calculate points for Users (belonging to Labs)
      l.users.each do |u|
        # Calculate User's daily points Average since they joined the lab
        u.daily_points     = (u.points / (today - u.joined.to_datetime).to_i)
        lab_daily_average += u.daily_points        
        u.save        
        lab_total_points  += u.points      	
	    end
      # End User points calculations

      # Set Lab's daily average using combined Users' daily averages
      l.daily_points = lab_daily_average

      # Reset Lab's total points to the combined total points of all CURRENT Users
      l.add_points(lab_total_points)
      l.save
    end
  end
end