class WelcomeMailsWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  
  def perform(user_id)
  	user = User.find(user_id)
  	lab = user.lab
  	UserMailer.welcome_email(user, lab).deliver
  end
end
