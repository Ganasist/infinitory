require 'spec_helper'

describe "Users" do

	describe "Signup" do
		
		describe "Failure" do
			it "should not create a new User" do
				lambda do
					visit "/register"
					fill_in "Email address", match: :first,		with: ""
					fill_in "Password",	match: :first,				with: ""
					fill_in "Password confirmation",					with: ""
					click_button "Sign up"
					
					current_path.should == "/"
					page.should have_content("Please review the problems below:")
					page.should have_content("can't be blank")
				end.should_not change{ User.count }
			end
		end

		describe "Success" do
			before(:all) do
				@gl  = create(:admin)
				Sidekiq::Extensions::DelayedMailer.jobs.clear
	    end

	    after(:each) do
		    Sidekiq::Extensions::DelayedMailer.jobs.clear
	    end

			it "should make a new non-gl User" do
				lambda do
					visit "/register"
					select "Technician", 											from: "user[role]"
					find('.js-email').set 'tests@factory.com'
					select @gl.email, match: :first, 	from: 	"user[lab_id]"
					find('.js-password').set 'loislane'
					find('.js-password-confirmation').set 'loislane'
					click_button "Sign up"					

					current_path.should == "/edit"
					page.should have_content("Please wait for approval to join the #{@gl.lab.name} lab")
					open_last_email.should be_delivered_to @gl.email
					assert_equal 1, Sidekiq::Extensions::DelayedMailer.jobs.size
					open_last_email.should have_subject "Confirmation instructions"
					expect { UserMailer.delay_for(1.second, retry: false).request_email }.to change(Sidekiq::Extensions::DelayedMailer.jobs, :size).by(1)
				end.should change{ User.count }.by(1)
			end

			it "should make a new gl User" do
				lambda do
					visit "/register"
					select "Group leader", 							from: "user[role]"
					find('.js-email').set "factory@test.com"
					fill_in "Institute name",						with: "Big Institute"
					find('.js-password').set 'loislane'
					find('.js-password-confirmation').set 'loislane'
					click_button "Sign up"					

					current_path.should == "/edit"
					page.should have_content("Please confirm your email address")
					open_last_email.should be_delivered_to "factory@test.com"
					open_last_email.should have_subject "Confirmation instructions"
					# expect { ConfirmationMailsWorker.perform_async }.to change(Devise::Async::Backend::Sidekiq.jobs, :size).by(1)
				end.should change{ User.count }.by(1)
			end
		end
	end
end
