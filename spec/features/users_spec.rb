require 'spec_helper'

describe "Users" do

	describe "signup" do
		
		describe "failure" do
			it "should not create a new User" do
				lambda do
					visit new_user_registration_path
					# page.select "", from: "User_role"
					fill_in "Email",									with: ""
					fill_in "Password",								with: ""
					fill_in "Password confirmation",	with: ""
					click_button "Sign up"
					
					current_path.should == "/"
					page.should have_content("Please review the problems below:")
					page.should have_content("can't be blank")
				end.should_not change{ User.count }
			end
		end

		describe "success" do
			before(:each) do
				@gl  = create(:admin)
				# @lab = Lab.create(email: @gl.email, institute: @gl.institute)
	    end

			it "should make a new non-gl User" do
				lambda do
					visit new_user_registration_path
					select "Technician", 							from: "user[role]"
					fill_in "Email",									with: "factory@test.com"
					select @gl.email, match: :first, 	from: "user[lab_id]"
					fill_in "Password",								with: "loislane"
					fill_in "Password confirmation",	with: "loislane"
					click_button "Sign up"					

					current_path.should == "/edit"
					page.should have_content("Please wait for approval to join the #{@gl.lab.name} lab")
					open_last_email.should be_delivered_to @gl.email
					open_last_email.should have_subject "Confirmation instructions"
				end.should change{ User.count }.by(1)
			end

			it "should make a new gl User" do
				lambda do
					visit new_user_registration_path
					select "Group leader", 						from: "user[role]"
					fill_in "Email",									with: "factory@test.com"
					fill_in "Institute name",					with: "Big Institute"
					fill_in "Password",								with: "loislane"
					fill_in "Password confirmation",	with: "loislane"
					click_button "Sign up"					

					current_path.should == "/edit"
					# page.should have_content("Please wait for approval to join the #{@lab.name} lab")
					open_last_email.should be_delivered_to "factory@test.com"
					open_last_email.should have_subject "Confirmation instructions"
				end.should change{ User.count }.by(1)
			end
		end
	end
end
