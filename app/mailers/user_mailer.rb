class UserMailer < ActionMailer::Base
  default from: 'example@example.com'
 
  def welcome_email(user, lab)
    @user = user
    @lab  = lab
    @url  = "#{new_user_session_url}"
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def farewell_email(user, lab)
    @user = user
    @lab  = lab
    mail(to: @user.email, subject: "Farewell from the #{@lab.name} lab")
  end

  def rejection_email(user, lab)
    @user = user
    @lab  = lab
    mail(to: @user.email, subject: "Farewell from the #{@lab.name} lab")
  end
end
