require 'spec_helper'

describe Ownership do
	context 'relationships' do
    expect_it { to belong_to(:user) }
    expect_it { to belong_to(:reagent) }
  end

  context 'database columns' do
    expect_it { to have_db_column(:device_id).of_type(:integer) }
    expect_it { to have_db_column(:reagent_id).of_type(:integer) }
    expect_it { to have_db_column(:user_id).of_type(:integer) }
    expect_it { to have_db_column(:created_at).of_type(:datetime) }
    expect_it { to have_db_column(:updated_at).of_type(:datetime) }
  end


  context 'Ownership methods' do

  end
end
