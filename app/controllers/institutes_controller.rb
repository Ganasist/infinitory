class InstitutesController < ApplicationController
  before_action :set_institute, only: [:show, :edit, :update, :destroy]
  before_action :find_institute, only: [:show]
  before_action :authenticate_user!, except: [:index, :show]

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
    @departments = Department.where(institute_id: find_institute)
    @labs = Lab.where(institute_id: find_institute).order("created_at ASC")

    # gon.rabl "app/views/institutes/show.json.rabl", as: "institute"
  end

  def new
    @institute = Institute.new
  end

  def edit
  end

  def create
    @institute = Institute.new(institute_params)
    respond_to do |format|
      if @institute.save
        format.html { redirect_to @institute, notice: 'Institute was successfully created.' }
        format.json { render action: 'show', status: :created, location: @institute }
      else
        format.html { render action: 'new' }
        format.json { render json: @institute.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @institute.update(institute_params)
        format.html { redirect_to @institute, notice: 'Institute was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @institute.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /institutes/1
  # DELETE /institutes/1.json
  def destroy
    @institute.destroy
    respond_to do |format|
      format.html { redirect_to institutes_url }
      format.json { head :no_content }
    end
  end

  private
    def set_institute
      @institute = Institute.friendly.find(params[:id])
    end

    def institute_params
      params.require(:institute).permit(:name, :email, :alternate_name, :address, :url, :acronym,
                                        :linkedin_url, :xing_url, :twitter_url, :facebook_url, :google_plus_url,
                                        :icon, :delete_icon, :icon_remote_url, :lock_version)
    end

    def find_institute
      @institute = Institute.friendly.find(params[:id])
      # if request.path != institute_path(@institute)
      #   return redirect_to @institute, :status => :moved_permanently
      # end
    end
end
