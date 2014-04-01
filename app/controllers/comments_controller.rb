class CommentsController < ApplicationController

	# Add USER-SPECIFIC authentication to this controller, 
	# ex:  before_action :check_user_show! in DevicesController

	# before_action :check_user
  before_action :authenticate_user!

	def destroy
    @comment = Comment.destroy(params[:id])
    respond_to do |format|
      format.html { redirect_to user_path(current_user) }
      format.xml  { head :ok }
      format.js
    end
  end

  private
  	# def check_user
  	# 	@comment = Comment.find(params[:id])
  	# 	unless @comment.commentable == current_user
   #      redirect_to current_user
   #      flash[:alert] = "You cannot access devices from that lab"
   #    end
  	# end
end