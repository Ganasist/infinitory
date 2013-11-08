require 'spec_helper'

describe Department do
  let(:department) { build(:department) }

  context 'relationships' do
    it { should belong_to(:institute) }
    it { should have_many(:labs) }
    it { should have_many(:users) }
  end

  context 'validations' do
    it { should validate_presence_of(:institute) }
    it { should validate_uniqueness_of(:name).case_insensitive.scoped_to(:institute_id).with_message(/A department with that name is already registered at this institute./) }
  end

  context 'database columns' do
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:latitude).of_type(:float) }
    it { should have_db_column(:longitude).of_type(:float) }
    it { should have_db_column(:institute_id).of_type(:integer) }
    it { should have_db_column(:country).of_type(:string) }
    it { should have_db_column(:room).of_type(:string) }
    it { should have_db_column(:address).of_type(:text) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
    it { should have_db_column(:country).of_type(:string) }
    it { should have_db_column(:url).of_type(:string) }
    it { should have_db_column(:users_count).of_type(:integer).with_options(default: 0) }
    it { should have_db_column(:labs_count).of_type(:integer).with_options(default: 0) }
    it { should have_db_column(:email).of_type(:string) }
  end

  context 'database indexes' do
    it { should have_db_index([:name, :institute_id]).unique(true) }
    it { should have_db_index(:email) }  
    it { should have_db_index(:institute_id) }  
    it { should have_db_index([:latitude, :longitude]) }
  end

  it 'has a valid department factory' do
    expect(department).to be_valid
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