class FarewellMailsWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  
  def perform(user_id, lab_id)
  	user = User.find(user_id)
  	lab = Lab.find(lab_id)
  	UserMailer.farewell_email(user, lab).deliver 
  end
end