# class RandomPointsWorker
#   include Sidekiq::Worker
#   include Sidetiq::Schedulable

#   recurrence backfill: true do
#     hourly
#   end
  
#   def perform
#     User.find_each do |t|
#     	t.add_points(rand(20))
#     	t.save
#     end
#   end
# end