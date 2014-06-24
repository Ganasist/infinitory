class SparklinePointsWorker

	include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence backfill: true do
    daily
  end
  
  def perform
  	User.where('joined < ?', 2.days.ago).find_in_batches do |b|
      b.each do |u|
	      
      	if Rails.env.production?
		      daily_score = u.sash.scores.first.score_points.where("created_at > ?", 24.hours.ago).sum(:num_points)
      	elsif Rails.env.development? || Rails.env.staging?
	      	daily_score = rand(25)
	      end

      	u.sparkline_points.push(daily_score)

      	if u.sparkline_points.length > 60
      		u.sparkline_points.shift
      	end

    		u.sparkline_points_will_change!
      	u.save
      end
    end
  end



end