class ConfirmationMailsWorker
  include Sidekiq::Worker
  sidekiq_options retry: false, backtrace: true
  
  def perform(user_id)
  	user = User.find(user_id)
  	user.send_confirmation_instructions
  end
end
