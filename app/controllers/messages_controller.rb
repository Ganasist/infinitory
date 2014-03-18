class MessagesController < ApplicationController
  before_action :authenticate_user!

  def new
    @feedback = Message.new
  end

  def create
    @feedback = Message.new(params[:message])
    @feedback.email = current_user.email
    @feedback.user = current_user.fullname
    if @feedback.valid?
      MessageMailer.delay(retry: false).feedback_email(@feedback.email, @feedback.user, @feedback.comment)
      redirect_to current_user, notice: "Your feedback is appreciated!"
      current_user.create_activity :feedback, owner: current_user
    else
      render 'new'
    end
  end

  private
    def message_params
      params.require(:message).permit(:message)
    end
end