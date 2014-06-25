class SparklinePointsWorker

	include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence backfill: true do
    daily
  end
  
  def perform
    Lab.find_each do |l|
      lab_daily_score = 0
    	l.users.each do |u|
    		user_daily_score = u.sash.scores.first.score_points.where("created_at > ?", 24.hours.ago).sum(:num_points)
	      lab_daily_score += user_daily_score

	      u.sparkline_points.push(user_daily_score)
      	
      	if u.sparkline_points.length > 60
      		u.sparkline_points = u.sparkline_points[-60..-1]
      	end
    		
    		u.sparkline_points_will_change!
      	u.save      	
	    end
    	
    	l.sparkline_points.push(lab_daily_score)
    	
    	if l.sparkline_points.length > 60
    		l.sparkline_points = l.sparkline_points[-60..-1]
    	end
  		
  		l.sparkline_points_will_change!
    	l.save
    end
  end
end