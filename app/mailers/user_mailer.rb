class UserMailer < ActionMailer::Base
  default from: 'admin@infinitory.com'
 
  def request_email(user, lab)
    @user = user
    @lab   = lab
    mail(to: @lab.email, subject:  "#{@user.fullname} would like to join your lab")
  end

  def welcome_email(user, lab)
    @user = user
    @lab  = lab
    mail(to: @user.email, subject: "Welcome to the #{@lab.name} lab")
  end

  def rejection_email(user, lab)
    @user = user
    @lab  = lab
    mail(to: @user.email, subject: "You cannot join the #{@lab.name} lab at this time")
  end

  def retire_email(user, lab)
    @user = user
    @lab  = lab
    mail(to: @user.email, subject: "Farewell from the #{@lab.name} lab")
  end
end
