class MessageMailer < ActionMailer::Base

  def feedback_email(email, user, comment)
    @email  = email
    @user = user
    @comment = comment
    mail(to: "trichereau@gmail.com", from: @email, subject: "Feedback from #{ @user }" )
  end

end
