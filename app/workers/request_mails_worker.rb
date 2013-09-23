class RequestMailsWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  
  def perform(user_id)
  	user = User.find(user_id)
  	gl = user.gl
  	UserMailer.request_email(user, gl).deliver 
  end
end