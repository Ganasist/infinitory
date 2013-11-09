require 'spec_helper'

describe Reagent do

  context 'relationships' do
    expect_it { to belong_to(:lab) }
  end

  context 'validations' do
    expect_it { to validate_presence_of(:lab) }
  end

  context 'database columns' do
  	expect_it { to have_db_column(:name).of_type(:string).with_options(null: false) }
  	expect_it { to have_db_column(:category).of_type(:string).with_options(null: false) }
		expect_it { to have_db_column(:location).of_type(:string) }    
    expect_it { to have_db_column(:price).of_type(:decimal).with_options(precision: 9, scale: 2) }
    expect_it { to have_db_column(:serial).of_type(:string) }
    expect_it { to have_db_column(:created_at).of_type(:datetime) }
    expect_it { to have_db_column(:updated_at).of_type(:datetime) }
		expect_it { to have_db_column(:properties).of_type(:hstore) }
    expect_it { to have_db_column(:lab_id).of_type(:integer) }
    expect_it { to have_db_column(:contact).of_type(:string) }
  end

  context 'database indexes' do
    expect_it { to have_db_index(:lab_id) }
    expect_it { to have_db_index(:properties) }
  end

end
