require 'spec_helper'

describe Department do
  let(:department) { build_stub(:department) }

  context 'database columns' do
    expect_it { to have_db_column(:name).of_type(:string).with_options(null: false) }
    expect_it { to have_db_column(:institute_id).of_type(:integer) }
    expect_it { to have_db_column(:address).of_type(:text) }
    expect_it { to have_db_column(:created_at).of_type(:datetime) }
    expect_it { to have_db_column(:updated_at).of_type(:datetime) }
    expect_it { to have_db_column(:url).of_type(:string) }
    expect_it { to have_db_column(:room).of_type(:string) }
    expect_it { to have_db_column(:users_count).of_type(:integer).with_options(default: 0) }
    expect_it { to have_db_column(:labs_count).of_type(:integer).with_options(default: 0) }
    expect_it { to have_db_column(:email).of_type(:string) }
    expect_it { to have_db_column(:icon_file_name).of_type(:string) }
    expect_it { to have_db_column(:icon_content_type).of_type(:string) }
    expect_it { to have_db_column(:icon_file_size).of_type(:integer) }
    expect_it { to have_db_column(:icon_updated_at).of_type(:datetime) }
    expect_it { to have_db_column(:icon_processing).of_type(:boolean) }
    expect_it { to have_db_column(:linkedin_url).of_type(:string) }
    expect_it { to have_db_column(:twitter_url).of_type(:string) }
    expect_it { to have_db_column(:xing_url).of_type(:string) }
    expect_it { to have_db_column(:facebook_url).of_type(:string) }
    expect_it { to have_db_column(:sash_id).of_type(:integer) }
    expect_it { to have_db_column(:level).of_type(:integer).with_options(default: 0) }
    expect_it { to have_db_column(:daily_points).of_type(:integer).with_options(default: 0) }
  end

  context 'database indexes' do
    expect_it { to have_db_index(:email).unique(true) }  
    expect_it { to have_db_index(:institute_id) }
    expect_it { to have_db_index([:name, :institute_id]).unique(true) }
  end

  context 'relationships' do
    expect_it { to belong_to(:institute) }
    expect_it { to have_many(:labs) }
    expect_it { to have_many(:users) }
  end

  context 'validations' do
    expect_it { to validate_presence_of(:institute) }
    expect_it { to validate_uniqueness_of(:name).case_insensitive.scoped_to(:institute_id).with_message(/A department with that name is already registered at this institute./) }
  end

  context 'methods' do

  end

  it 'is invalid without a name' do
    expect(build(:department, name: "")).to have(1).errors_on(:name)
  end

  it 'is invalid without an institute' do
    expect(build(:department, institute: nil)).to have(1).errors_on(:institute)
  end

  it 'is valid with a valid URL' do
    urls = %w[http://www.foo.bar http://research.com www.foo.bar.baz http://bbb.co.uk]
    urls.each do |url|
      valid_url_department = build(:department, url: url)
      expect(valid_url_department).to have(0).errors_on(:url)
    end
  end

  it 'is invalid with an invalid URL' do
    urls = %w[htp:/www.foo.bar lkjlkjl www.research@com http://sdjfslfjslfjslfsjflskfj]
    urls.each do |url|
      invalid_url_department = build(:department, url: url)
      expect(invalid_url_department).to have(1).errors_on(:url)
    end
  end

  it { should respond_to(:location) }
  describe 'it should respond to the location method' do
    it 'should return only its institutes address if it does not have a room' do
      department.save
      expect(department.location).to eql department.institute.address
    end

    it 'should return lab and institute location if the lab does not have a department' do
      department.room = "420a"
      department.save
      expect(department.location).to eql "#{department.room} #{department.institute.address}"
    end
  end
end