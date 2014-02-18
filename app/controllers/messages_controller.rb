class MessagesController < ApplicationController
  before_action :authenticate_user!

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])
    @message.email = current_user.email
    @message.username = current_user.fullname
    if @message.valid?
      UserMailer.delay(retry: false).feedback_email(@message)
      current_user.create_activity :feedback, owner: current_user
      redirect_to current_user, notice: "Feedback sent. Your input is appreciated!"
      User.find_by(email: @message.email).add_points(1)
    else
      render "new"
    end
  end
end