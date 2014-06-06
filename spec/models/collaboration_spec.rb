require 'spec_helper'

describe Collaboration do
	context "database columns" do
		expect_it { to have_db_column(:lab_id).of_type(:integer) }
		expect_it { to have_db_column(:collaborator_id).of_type(:integer) }
		expect_it { to have_db_column(:created_at).of_type(:datetime) }
		expect_it { to have_db_column(:updated_at).of_type(:datetime) }
	end

	context "database indexes" do
		expect_it { to have_db_index([:lab_id, :collaborator_id]).unique(true) }
	end

	context "relationships" do
	end

	context "validations" do
	end

	context "methods" do
	end
end
