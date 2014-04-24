class UserMailer < ActionMailer::Base
  default from: 'noreply@infinitory.com'

  def request_email(user_id, lab_id)
    @user = User.find(user_id)
    @lab  = Lab.find(lab_id)
    @test = @lab.gl_lm.pluck(:email)
    mail(to: @lab.gl_lm.pluck(:email), subject:  "#{ @user.fullname } would like to join your lab")
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

  def gl_signup_admin_email(user_id)
    @user = User.find(user_id)
    mail(to: "admin@infinitory.com", subject: "A group leader #{@user.email} has signed up!")
  end
  
end
