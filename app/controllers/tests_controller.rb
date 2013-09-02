class TestsController < ApplicationController

	def index
		@test = Institute.order(:name).where("name ilike ?", "%#{params[:term]}%")
	  render json: @test.map(&:name)
	end 

end
