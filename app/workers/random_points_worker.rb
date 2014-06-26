class RandomPointsWorker

	include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence backfill: true do
    daily
  end
  
	if Rails.env.development? || Rails.env.staging?
	  def perform
	  	Lab.find_each do |l|
	  		l.users.each do |u|
	  			# Add random points each day to Users in Dev and Staging
	        u.add_points(rand(50))          
	       end
	     end
    end
  end
 end