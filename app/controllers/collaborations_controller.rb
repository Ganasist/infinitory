class CollaborationsController < ApplicationController
	before_action :set_lab, only: [:index, :create]
	before_action :authenticate_user!
  before_action :check_user!

	def index
		@collaborator = Collaboration.new
	end

	def create
		@collaborator = Lab.find_by(email: collaboration_params[:collaborator_id])
    if !@collaborator.nil?
  	  @collaboration = @lab.collaborations.build(collaborator_id: @collaborator.id)
  	  respond_to do |format|
        if @collaboration.save
          format.html { redirect_to lab_collaborations_path(current_user.lab), 
                        notice: "You are now collaborating with the #{ @collaborator.gl.fullname } lab." }
          format.json { render action: 'show', status: :created, location: @lab }
        else
          format.html { render action: 'index' }
          format.json { render json: @collaboration.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to lab_collaborations_path(current_user.lab), 
                      notice: "You must enter a valid email address." }
        format.json { render action: 'show', status: :created, location: @lab }
      end
    end
	end

  def destroy
    @collaboration = current_user.lab.collaborations.find(params[:id])
    @collaboration.destroy
    flash[:notice] = "Your collaboration with #{ @collaboration.collaborator.gl.fullname } has ended."
    redirect_to lab_collaborations_path(current_user.lab)
  end

  def destroy_inverse
    @collaboration = current_user.lab.inverse_collaborations.find(params[:id])
    @collaboration.destroy
    flash[:notice] = "Your no longer can access items from #{ @collaboration.lab.gl.fullname }'s group."
    redirect_to lab_collaborations_path(current_user.lab)
  end

	private
		def check_user!
      if current_user.lab != @lab && !current_user.gl?
        redirect_to current_user
        flash[:alert] = "You cannot access reagents from that lab"
      end
    end

    def set_lab
      @lab = Lab.find(params[:lab_id])   
    end

		def collaboration_params
      params.require(:collaboration).permit(:lab_id, :collaborator_id)
    end
end