require 'spec_helper'

describe InstitutesController do	

  describe 'guest access' do
  	
	  it 'does not require login to see the index' do
			sign_in nil
	  	get :index, use_route: institutes_path
	  	expect(response).to be_success
	  end

	  it 'does not require login to see institute Show page' do
	  	sign_in nil
	  	institute  = Institute.create!(name: "Test")
	  	visit institute_path(institute)
	  	# get :show, use_route: institute_path(institute)
	  	expect(response).to be_success
	  end
	end
end
