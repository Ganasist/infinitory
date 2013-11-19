require 'spec_helper'

describe Reagent do
  let(:reagent) { build(:reagent) }

  context 'relationships' do
    expect_it { to belong_to(:lab) }
    expect_it { to belong_to(:user) }
  end

  context 'validations' do
    expect_it { to validate_presence_of(:name) }
    expect_it { to validate_presence_of(:lab) }
    expect_it { to ensure_inclusion_of(:category).in_array(%w[antibody chemical_(powder) chemical_(solution) enzyme kit cell_line]) }
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
    expect_it { to have_db_column(:user_id).of_type(:integer) }
  end

  context 'database indexes' do
    expect_it { to have_db_index(:lab_id) }
    expect_it { to have_db_index(:user_id) }
    expect_it { to have_db_index(:properties) }
  end

  it 'is invalid without a lab' do
    reagent.lab = nil
    expect(reagent).to have(1).errors_on(:lab)
  end

  it 'is valid without a user' do
    reagent.user = nil
    expect(reagent).to have(0).errors_on(:user)
  end

  it 'is invalid without a category' do
    reagent.category = nil
    expect(reagent).to have(2).errors_on(:category)
  end

  it 'is invalid with an invalid category' do
    categories = %w[foo baz bar nerf bork]
    categories.each do |category|
      invalid_category_reagent = build(:reagent, category: category)
      expect(invalid_category_reagent).to have(1).errors_on(:category)
    end
  end


end