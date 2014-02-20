class MessageMailer < ActionMailer::Base

  def feedback_email(email, username, comment)
    @email  = email
    @username = username
    @comment = comment
    mail(to: 'trichereau@gmail.com', subject: 'Feedback')
  end
  
end
