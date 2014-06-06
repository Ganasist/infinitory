require 'spec_helper'

describe Ownership do

  context 'database columns' do
    expect_it { to have_db_column(:user_id).of_type(:integer) }
    expect_it { to have_db_column(:reagent_id).of_type(:integer) }
    expect_it { to have_db_column(:device_id).of_type(:integer) }
    expect_it { to have_db_column(:created_at).of_type(:datetime) }
    expect_it { to have_db_column(:updated_at).of_type(:datetime) }
  end

  context 'database indexes' do
    expect_it { to have_db_index([:user_id, :device_id]).unique(true) }    
    expect_it { to have_db_index([:user_id, :reagent_id]).unique(true) }
  end 

  context 'relationships' do
    expect_it { to belong_to(:user) }
    expect_it { to belong_to(:reagent) }
  end

  context 'validations' do

  end

  context 'methods' do

  end
  
end
