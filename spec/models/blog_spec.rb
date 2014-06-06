require 'spec_helper'

describe Blog do
	
	context "database columns" do
		expect_it { to have_db_column(:title).of_type(:string) }
		expect_it { to have_db_column(:entry).of_type(:text) }
		expect_it { to have_db_column(:created_at).of_type(:datetime) }
		expect_it { to have_db_column(:updated_at).of_type(:datetime) }
		expect_it { to have_db_column(:url).of_type(:string).with_options(default: "#") }
		expect_it { to have_db_column(:bitly_url).of_type(:string) }
	end

	context "database indexes" do
		
	end

	context "relationships" do
	end

	context "validations" do
	end

	context "methods" do
	end

end
