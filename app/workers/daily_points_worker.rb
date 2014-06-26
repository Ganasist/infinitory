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
      lab_today_score   = 0
      lab_daily_average = 0
      lab_total_points  = 0
      l.subtract_points(l.points)    	

      # Calculate points for Users (belonging to Labs) #
      l.users.each do |u|
        # Add random points each day to Users in Dev and Staging
        if Rails.env.development? || Rails.env.staging?
          u.add_points(rand(50))          
        end

        # Calculate User's daily points Average since they joined the lab
        u.daily_points     = (u.points / (today - u.joined.to_datetime).to_i)
        lab_daily_average += u.daily_points

        # Start User Sparkline calculations using User's points in the past 24 hours #
    		user_today_score  = u.sash.scores.first.score_points.where("created_at > ?", 24.hours.ago).sum(:num_points)
	      lab_today_score  += user_today_score
        
        u.sparkline_points.push(user_today_score)

        # Make sure the user.sparkline_points array doesn't exceed 60
      	if u.sparkline_points.length > 60
      		u.sparkline_points = u.sparkline_points[-60..-1]
      	end    		
    		u.sparkline_points_will_change!
        # End User Sparkline calculations #
        u.save       
        
        lab_total_points  += u.points      	
	    end
      # End User points calculations #

      # Set Lab's daily average using combined Users' daily averages #
      l.daily_points = lab_daily_average

       # Reset Lab's total points to the combined total points of all CURRENT Users #
      l.add_points(lab_total_points)

      # Start Lab Sparkline calculations using combined User points in the past 24 hours #
    	l.sparkline_points.push(lab_today_score)
      
      # Make sure the lab.sparkline_points array doesn't exceed 60
    	if l.sparkline_points.length > 60
    		l.sparkline_points = l.sparkline_points[-60..-1]
    	end  		
  		l.sparkline_points_will_change!  	
      # End Lab Sparkline calculations #
      l.save
    end
  end
end