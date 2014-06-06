require 'spec_helper'

describe Device do
  let(:device) { build(:device) }

  context 'relationships' do
    expect_it { to belong_to(:lab).counter_cache(true).touch(true) }
    expect_it { to have_many(:ownerships).dependent(:destroy) }
    expect_it { to have_many(:users).through(:ownerships) }
  end

  context 'validations' do
    expect_it { to validate_presence_of(:name) }
    expect_it { to validate_presence_of(:lab) }
    expect_it { to ensure_inclusion_of(:currency).in_array(%w[$ €]) }    
    expect_it { to validate_numericality_of(:price).with_message(/Must be a positive number or 0/).is_greater_than_or_equal_to(0) }
    expect_it { to_not allow_value(-1).for(:price) }
    expect_it { to ensure_length_of(:description).is_at_most(223) }
  end

  context 'database columns' do
  	expect_it { to have_db_column(:name).of_type(:string).with_options(null: false) }
    expect_it { to have_db_column(:location).of_type(:string) }
    expect_it { to have_db_column(:serial).of_type(:string) }
    expect_it { to have_db_column(:lab_id).of_type(:integer) }
    expect_it { to have_db_column(:product_url).of_type(:string) }
    expect_it { to have_db_column(:uid).of_type(:string) }
    expect_it { to have_db_column(:description).of_type(:text) }
    expect_it { to have_db_column(:price).of_type(:decimal).with_options(precision: 9, scale: 2, default: 0.0, null: false) }
    expect_it { to have_db_column(:created_at).of_type(:datetime) }
    expect_it { to have_db_column(:updated_at).of_type(:datetime) }
    expect_it { to have_db_column(:status).of_type(:boolean).with_options(default: true) }
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
    expect_it { to have_db_column(:state).of_type(:string) }
    expect_it { to have_db_column(:bookings_count).of_type(:integer) }
    expect_it { to have_db_column(:users_count).of_type(:integer) }
    expect_it { to have_db_column(:bookable).of_type(:boolean) }
  end

  context 'database indexes' do
    expect_it { to have_db_index([:lab_id, :name, :uid]).unique(true) }
    expect_it { to have_db_index(:lab_id) }
    expect_it { to have_db_index(:tsv_body) }
  end

  context 'Device methods' do

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

  it 'is valid without a serial number' do
    device.serial = nil
    expect(device).to have(0).errors_on(:serial)
  end
end