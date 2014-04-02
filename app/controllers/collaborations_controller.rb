class CollaborationsController < ApplicationController
	before_action :set_lab, only: [:index, :create]
	before_action :authenticate_user!
  before_action :check_user!, only: [:index, :create]

	def index
		@collaborator = Collaboration.new
	end

	def create
		@collaborator = Lab.find_by(email: collaboration_params[:lab_email])
    if !@collaborator.nil? && (@collaborator != @lab) && !@lab.collaborators.include?(@collaborator)
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
    elsif @collaborator == @lab
      respond_to do |format|
        flash[:error] = "You cannot collaborate with yourself."
        format.html { redirect_to lab_collaborations_path(current_user.lab) }
        format.json { render action: 'show', status: :created, location: @lab }
      end
    elsif @lab.collaborators.include?(@collaborator)
      respond_to do |format|
        flash[:error] = "You are already collaborating with that lab."
        format.html { redirect_to lab_collaborations_path(current_user.lab) }
        format.json { render action: 'show', status: :created, location: @lab }
      end
    else
      respond_to do |format|
        flash[:error] = "We cannot locate a lab with that email address."
        format.html { redirect_to lab_collaborations_path(current_user.lab) }
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
    flash[:notice] = "You can no longer can access items from that group."
    redirect_to lab_collaborations_path(current_user.lab)
  end

	private
		def check_user!
      unless current_user.gl_lm_lab?(@lab)
        redirect_to current_user
        flash[:alert] = "You cannot access that page"
      end
    end

    def set_lab
      @lab = Lab.find(params[:lab_id])   
    end

		def collaboration_params
      params.require(:collaboration).permit(:lab_id, :collaborator_id, :lab_email)
    end
end