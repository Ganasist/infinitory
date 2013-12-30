class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])
    if @message.valid?
      UserMailer.delay(retry: false).feedback_email(@message)
      redirect_to current_user, notice: "Feedback sent. Your input is appreciated!"
    else
      render "new"
    end
  end
end