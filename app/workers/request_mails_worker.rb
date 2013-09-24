class RequestMailsWorker
  include Sidekiq::Worker
  sidekiq_options retry: false, backtrace: true
  
  def perform(user_id, lab_id)
  	user = User.find(user_id)
  	lab  = Lab.find(lab_id)
  	UserMailer.request_email(user, lab).deliver 
  end
end