require 'spec_helper'

describe Reagent do
  let(:reagent) { build(:reagent) }

  context 'database columns' do
    expect_it { to have_db_column(:name).of_type(:string).with_options(null: false) }
    expect_it { to have_db_column(:location).of_type(:string) }
    expect_it { to have_db_column(:price).of_type(:decimal).with_options(precision: 9, scale: 2, default: 0.0, null: false) }
    expect_it { to have_db_column(:serial).of_type(:string) }
    expect_it { to have_db_column(:created_at).of_type(:datetime) }
    expect_it { to have_db_column(:updated_at).of_type(:datetime) }    
    expect_it { to have_db_column(:lab_id).of_type(:integer) }
    expect_it { to have_db_column(:product_url).of_type(:string) }
    expect_it { to have_db_column(:expiration).of_type(:date) }
    expect_it { to have_db_column(:remaining).of_type(:integer).with_options(default: 100, null: false) }
    expect_it { to have_db_column(:uid).of_type(:string) }
    expect_it { to have_db_column(:lot_number).of_type(:string) }
    expect_it { to have_db_column(:quantity).of_type(:string) }
    expect_it { to have_db_column(:icon_file_name).of_type(:string) }
    expect_it { to have_db_column(:icon_content_type).of_type(:string) }
    expect_it { to have_db_column(:icon_file_size).of_type(:integer) }
    expect_it { to have_db_column(:icon_updated_at).of_type(:datetime) }
    expect_it { to have_db_column(:tsv_body).of_type(:tsvector) }
    expect_it { to have_db_column(:purchasing_url).of_type(:string) }
    expect_it { to have_db_column(:pdf_file_name).of_type(:string) }
    expect_it { to have_db_column(:pdf_content_type).of_type(:string) }
    expect_it { to have_db_column(:pdf_file_size).of_type(:integer) }
    expect_it { to have_db_column(:pdf_updated_at).of_type(:datetime) }
    expect_it { to have_db_column(:icon_processing).of_type(:boolean) }
    expect_it { to have_db_column(:currency).of_type(:string).with_options(default: "$") }
    expect_it { to have_db_column(:shared).of_type(:boolean).with_options(default: false, null: false) }
    expect_it { to have_db_column(:description).of_type(:text) }
    expect_it { to have_db_column(:users_count).of_type(:integer).with_options(default: 0) }
  end

  context 'database indexes' do    
    expect_it { to have_db_index(:expiration) }
    expect_it { to have_db_index([:lab_id, :name, :uid, :description]).unique(true) }
    expect_it { to have_db_index(:lab_id) }
    expect_it { to have_db_index(:tsv_body) }
  end

  context 'relationships' do
    expect_it { to belong_to(:lab) }
    expect_it { to have_many(:ownerships) }
    expect_it { to have_many(:users).through(:ownerships) }
  end

  context 'validations' do
    expect_it { to validate_presence_of(:name) }
    expect_it { to validate_presence_of(:lab) }
    expect_it { to ensure_inclusion_of(:category).in_array(%w[antibody cell_culture cell_line chemical_powder chemical_solution DNA_sample enzyme kit RNA_sample vector]) }
    expect_it { to validate_numericality_of(:price).with_message(/Must be a positive number or 0/) }
    expect_it { to_not allow_value(-1).for(:price) }
    expect_it { to validate_numericality_of(:remaining) }
  end

  context 'methods' do

  end

  it 'is invalid without a lab' do
    reagent.lab = nil
    expect(reagent).to have(1).errors_on(:lab)
  end

  it 'is valid without a user' do
    reagent.users = nil
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

  it 'defaults to expiring 3 years into the future if expiration is not explicitly set' do
    reagent.expiration = nil
    reagent.save
    expect(reagent.expiration).to eql (Date.today + 3.years)
  end
end