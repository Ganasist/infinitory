require 'spec_helper'

describe Feedback do
	# let(:feedback) { create(:feedback) }

	context "validations" do
		expect_it { to validate_presence_of(:email) }
		expect_it { to allow_value('feedback@infinitory.com').for(:email) }
		expect_it { to_not allow_value('asdfjkl').for(:email) }
		expect_it { to validate_presence_of(:user) }
		expect_it { to ensure_length_of(:comment).is_at_most(223) }
		expect_it { to validate_presence_of(:comment).with_message("Feedback can't be blank") }
	end
end
