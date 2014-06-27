class SparklineWorker
	include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence backfill: true do
    daily
  end

	def perform
		Lab.find_each do |l|
      lab_today_score = 0
			l.users.each do |u|
				# Start User Sparkline calculations using User's points in the past 24 hours
    		user_today_score  = u.sash.scores.first.score_points.where("created_at > ?", 24.hours.ago).sum(:num_points)
	      lab_today_score  += user_today_score
        
        u.sparkline_points.push(user_today_score)

        # Make sure the user.sparkline_points array doesn't exceed 60
      	if u.sparkline_points.length > 60
      		u.sparkline_points = u.sparkline_points[-60..-1]
      	end    		
    		u.sparkline_points_will_change!
        # End User Sparkline calculations
        u.save
      end

      # Start Lab Sparkline calculations using combined User points in the past 24 hours
    	l.sparkline_points.push(lab_today_score)
      
      # Make sure the lab.sparkline_points array doesn't exceed 60
    	if l.sparkline_points.length > 60
    		l.sparkline_points = l.sparkline_points[-60..-1]
    	end  		
  		l.sparkline_points_will_change!  	
      # End Lab Sparkline calculations
      l.save
    end		
	end
end