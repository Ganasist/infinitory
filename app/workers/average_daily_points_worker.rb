class AverageDailyPointsWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence backfill: true do
    daily
  end
  
  def perform
    # User's average daily points
    today = DateTime.now
    User.where('joined < ?', 2.days.ago).find_each do |u|
        if Rails.env.development? || Rails.env.staging?
          u.add_points(rand(50))          
        end
      	u.daily_points = (u.points / (today - u.joined.to_datetime).to_i)
      	u.save
    end

    # Lab's average and total points. This is a snapshot of lab's CURRENT members, not an historical average!!
    Lab.find_each do |l|
      lab_daily_points = 0
      lab_total_points = 0
      l.subtract_points(l.points)
      l.users.each do |u|
        lab_daily_points += u.daily_points
        lab_total_points += u.points
      end
      l.daily_points = lab_daily_points
      l.add_points(lab_total_points)
      l.save
    end
  end

end