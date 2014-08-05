class InstitutesController < ApplicationController
  before_action :set_institute, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  after_action :verify_authorized, except: :index

  def index
    if params[:search].present?
      @institutes = Institute.near(params[:search], 50)
    elsif params[:query].present?
      @institutes = Institute.global_search(params[:query]).page(params[:page]).per_page(10)
    elsif params[:term].present?
      @institutes = Institute.order(:name).where("name ilike ?", "%#{params[:term]}%")
      render json: @institutes.map(&:name)
    else 
      @institutes = Institute.order(updated_at: :desc).page(params[:page]).per_page(10)
    end
  end

  def show
    authorize @institute
    @departments = Department.where(institute: @institute)
    @labs = Lab.where(institute: @institute).order("created_at ASC")
  end

  def new
    @institute = Institute.new
    authorize @institute
  end

  def edit
    authorize @institute
  end

  def create
    @institute = Institute.new(institute_params)
    authorize @institute
    respond_to do |format|
      if @institute.save
        format.html { redirect_to @institute }
        format.json { render action: 'show', status: :created, location: @institute }
      else
        format.html { render action: 'new' }
        format.json { render json: @institute.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @institute
    respond_to do |format|
      if @institute.update(institute_params)
        format.html { redirect_to @institute }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @institute.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @institute.destroy
    respond_to do |format|
      format.html { redirect_to institutes_url }
      format.json { head :no_content }
    end
  end

  private
    rescue_from ActiveRecord::RecordNotFound do |exception|
      if user_signed_in?
        flash[:alert] = "Institute wasn't found."
        redirect_to current_user
      else
        flash[:alert] = "You need to sign in or sign up before continuing."
        redirect_to root_url
      end
    end

    def set_institute
      @institute = Institute.find(params[:id])
    end

    def institute_params
      params.require(:institute).permit(:name, :email, :alternate_name, :address, :url, :acronym, :time_zone,
                                        :linkedin_url, :xing_url, :twitter_url, :facebook_url,
                                        :icon, :delete_icon, :icon_remote_url,
                                        :pdf, :delete_pdf, :pdf_remote_url)
    end
end
