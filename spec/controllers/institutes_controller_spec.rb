require 'spec_helper'



describe InstitutesController do

  describe 'guest access' do

	  it 'does not require login to see the index' do
	  	sign_in nil

	  	get :index, use_route: institutes_path
	  	expect(response).to be_success
	  end

	  it 'requires login to see pages other than index' do
	  	institute  = create(:institute)
	  	sign_in nil

	  	get :show, use_route: institute_path(institute)
	  	expect(response).to redirect_to login_path
	  end
	end

	describe 'member access' do

	end
end
