require 'spec_helper'

describe Booking do

	context "database columns" do
		expect_it { to have_db_column(:start_time).of_type(:datetime) }
		expect_it { to have_db_column(:end_time).of_type(:datetime) }		
		expect_it { to have_db_column(:device_id).of_type(:integer) }
		expect_it { to have_db_column(:user_id).of_type(:integer) }
		expect_it { to have_db_column(:updated_at).of_type(:datetime) }
		expect_it { to have_db_column(:all_day).of_type(:boolean) }
		expect_it { to have_db_column(:duration).of_type(:integer) }
	end

	context "database indexes" do
		expect_it { to have_db_index(:device_id) }
		expect_it { to have_db_index(:end_time) }
		expect_it { to have_db_index(:start_time) }
		expect_it { to have_db_index(:user_id) }
	end

	context "relationships" do
	end

	context "validations" do
	end

	context "methods" do
	end

end
