class MessageMailer < ActionMailer::Base

  def feedback_email(email, username, comment)
    @email  = email
    @username = username
    @comment = comment
    mail(to: 'trichereau@gmail.com', from: @email, subject: 'Feedback')
  end

end
