class RequestMailsWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  
  def perform(user_id)
  	user = User.find(user_id)
  	UserMailer.request_email(user, user.gl).deliver 
  end
end