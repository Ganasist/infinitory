class CollaborationsController < ApplicationController
	before_action :set_lab, only: [:index, :create]
	before_action :authenticate_user!
  before_action :check_user!, only: :show

	def index
		@collaborator = Collaboration.new
		@labs = Lab.all
		@outgoing = @lab.collaborators
	end

	def create
		@collaborator = Lab.find_by(email: collaboration_params[:collaborator_id])
	  @collaboration = @lab.collaborations.build(collaborator_id: @collaborator.id)
	  respond_to do |format|
      if @collaboration.save
        format.html { redirect_to lab_path(@lab), 
                      notice: "You are now sharing with the #{ @collaborator.gl.fullname } lab." }
        format.json { render action: 'show', status: :created, location: @lab }
      else
        format.html { render action: 'index' }
        format.json { render json: @collaboration.errors, status: :unprocessable_entity }
      end
    end
	end

	private
		def check_user!
      if current_user.lab != Reagent.find(params[:id]).lab
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