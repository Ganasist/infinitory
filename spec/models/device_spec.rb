require 'spec_helper'

describe Device do
  let(:device) { build(:device) }

  context 'relationships' do
    expect_it { to belong_to(:lab) }
    expect_it { to have_many(:ownerships) }
    expect_it { to have_many(:users).through(:ownerships) }
  end

  context 'validations' do
    expect_it { to validate_presence_of(:name) }
    expect_it { to validate_presence_of(:lab) }
    expect_it { to ensure_inclusion_of(:category).in_array(%w[calocages FACS microscope PCR_machine]) }
    expect_it { to validate_numericality_of(:price).with_message(/Must be a positive number or 0/) }
    expect_it { to_not allow_value(-1).for(:price) }
  end

  context 'database columns' do
  	expect_it { to have_db_column(:name).of_type(:string).with_options(null: false) }
  	expect_it { to have_db_column(:category).of_type(:string).with_options(null: false) }
		expect_it { to have_db_column(:location).of_type(:string) }
		expect_it { to have_db_column(:uid).of_type(:string) }
		expect_it { to have_db_column(:description).of_type(:text) } 
    expect_it { to have_db_column(:url).of_type(:string) }    
    expect_it { to have_db_column(:price).of_type(:decimal).with_options(precision: 9, scale: 2) }
    expect_it { to have_db_column(:serial).of_type(:string) }
    expect_it { to have_db_column(:created_at).of_type(:datetime) }
    expect_it { to have_db_column(:updated_at).of_type(:datetime) }
    expect_it { to have_db_column(:lab_id).of_type(:integer) }
    expect_it { to have_db_column(:user_id).of_type(:integer) }
    expect_it { to have_db_column(:icon).of_type(:string) }
    expect_it { to have_db_column(:icon_processing).of_type(:boolean) }
    expect_it { to have_db_column(:lock_version).of_type(:integer).with_options(default: 0, null: false) }
  end

  context 'database indexes' do
    expect_it { to have_db_index([:lab_id, :name, :uid, :category]).unique(true) }
    expect_it { to have_db_index(:lab_id) }
    expect_it { to have_db_index(:user_id) }
  end

  it 'is invalid without a lab' do
    device.lab = nil
    expect(device).to have(1).errors_on(:lab)
  end

  it 'is valid without a user' do
    device.users = nil
    device.save
    expect(device).to have(0).errors_on(:user)
  end

  it 'is invalid without a category' do
    device.category = nil
    expect(device).to have(2).errors_on(:category)
  end

  it 'is invalid with an invalid category' do
    categories = %w[foo baz bar nerf bork]
    categories.each do |category|
      invalid_category_device = build(:device, category: category)
      expect(invalid_category_device).to have(1).error_on(:category)
    end
  end

  it 'is valid without a serial number' do
    device.serial = nil
    expect(device).to have(0).errors_on(:serial)
  end
end