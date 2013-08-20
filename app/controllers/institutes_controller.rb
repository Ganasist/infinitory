class InstitutesController < ApplicationController
  before_action :set_institute, only: [:show, :edit, :update, :destroy]
  before_action :find_institute, only: [:show]

  # GET /institutes
  # GET /institutes.json
  def index
    if params[:search].present?
      @institutes = Institute.near(params[:search], 50)
      @circles_json = @institutes.to_gmaps4rails do |institute|
                       {lng: "#{institute.longitude}",
                        lat: "#{institute.latitude}",
                        radius: 20,
                        strokeColor: "#FF0000",
                        strokeOpacity: 0.8,
                        strokeWeight: 1,
                        fillColor: "#000",
                        fillOpacity: 0.35}
        end
        @mapped = @institutes.to_gmaps4rails do |institute, marker|
          marker.infowindow "<h4>#{institute.name}<h4>
                            <h5>Labs: #{institute.labs.count}</h5>"
        end
    elsif params[:query].present?
      @institutes = Institute.global_search(params[:query]).page(params[:page]).per_page(10)
      @circles_json = @institutes.to_gmaps4rails do |institute|
                       {lng: "#{institute.longitude}",
                        lat: "#{institute.latitude}",
                        radius: 20,
                        strokeColor: "#FF0000",
                        strokeOpacity: 0.8,
                        strokeWeight: 1,
                        fillColor: "#000",
                        fillOpacity: 0.35}
       end
      @mapped = @institutes.to_gmaps4rails do |institute, marker|
        marker.infowindow "<h4>#{institute.name}<h4>
                          <h5>Labs: #{institute.labs.count}</h5>"
        end
    else  
      @institutes = Institute.order(updated_at: :desc).page(params[:page]).per_page(10)
      @departments = Department.all.count
      @labs  = Lab.all.count
      @mapped = Institute.order(updated_at: :desc).page(params[:page]).per_page(10).to_gmaps4rails do |institute, marker|
        marker.infowindow "<h4>#{institute.name}<h4>
                          <h5>Labs: #{institute.labs.count}</h5>"
      end
    end
  end

  # GET /institutes/1
  # GET /institutes/1.json
  def show
    @departments = Department.where(institute_id: @institute).order(name: :asc)
    @mapped = @institute.to_gmaps4rails  do |institute, marker|
        marker.infowindow "<h4>#{institute.name}<h4>
                          <h5>Labs: #{institute.labs.count}</h5>"
        end
  end

  # GET /institutes/new
  def new
    @institute = Institute.new
  end

  # GET /institutes/1/edit
  def edit
  end

  # POST /institutes
  # POST /institutes.json
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

  # PATCH/PUT /institutes/1
  # PATCH/PUT /institutes/1.json
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
    # Use callbacks to share common setup or constraints between actions.
    def set_institute
      @institute = Institute.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def institute_params
      params.require(:institute).permit(:name, :alternate_name, :address, :url, :acronym, :slug)
    end

    def find_institute
      @institute = Institute.friendly.find(params[:id])
      if request.path != institute_path(@institute)
        return redirect_to @institute, :status => :moved_permanently
      end
    end
end
