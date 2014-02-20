class UserMailer < ActionMailer::Base

  def request_email(user_id, lab_id)
    @user = User.find(user_id)
    @lab   = Lab.find(lab_id)
    mail(to: @lab.email, subject:  "#{ @user.fullname } would like to join your lab")
  end

  def welcome_email(user_id, lab_id)
    @user = User.find(user_id)
    @lab  = Lab.find(lab_id)
    mail(to: @user.email, subject: "Welcome to the #{ @lab.gl.fullname } lab")
  end

  def rejection_email(user_id, lab_id)
    @user = User.find(user_id)
    @lab  = Lab.find(lab_id)
    mail(to: @user.email, subject: "You cannot join the #{ @lab.gl.fullname } lab at this time")
  end

  def retire_email(user_id, lab_id)
    @user = User.find(user_id)
    @lab  = Lab.find(lab_id)
    mail(to: @user.email, subject: "Farewell from the #{ @lab.gl.fullname } lab")
  end

  def feedback_email(email, username, message)
    @email    = email
    @username = username
    @message  = message
    mail(from: @email, to: "feedback@infinitory.com", subject: "Feedback from #{ @username }")
  end
  
end
