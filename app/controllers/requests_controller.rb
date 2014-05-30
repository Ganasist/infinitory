class RequestsController < ApplicationController

	def new
    @request = Request.new
  end

  def create
    @request = Request.new(message_params)
    if @request.save
      RequestMailer.delay(retry: false).request_email(@request.email, @request.department, @request.institute)
      redirect_to root_path, notice: 'Your request has been sent. We will contact you soon!'
    else
      render 'new'
    end
  end

  private
    def message_params
      params.require(:request).permit(:email, :department, :institute)
    end
end
