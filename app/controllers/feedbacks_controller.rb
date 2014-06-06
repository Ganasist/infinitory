class FeedbacksController < ApplicationController
  before_action :authenticate_user!

  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(params[:feedback])
    @feedback.email = current_user.email
    @feedback.user = current_user.fullname
    if @feedback.valid?
      FeedbackMailer.delay(retry: false).feedback_email(@feedback.email, @feedback.user, @feedback.comment)
      current_user.create_activity :feedback, owner: current_user
      redirect_to current_user, notice: 'Your feedback is appreciated!'
    else
      render 'new'
    end
  end

  private
    def feedback_params
      params.require(:feedback).permit(:feedback)
    end
end