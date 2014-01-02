class MessagesController < ApplicationController
  before_action :authenticate_user!

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])
    @message.email = current_user.email
    if @message.valid?
      UserMailer.delay(retry: false).feedback_email(@message)
      current_user.add_points(5)
      redirect_to current_user, notice: "Feedback sent. Your input is appreciated!"
    else
      @message
      render "new"
    end
  end
end