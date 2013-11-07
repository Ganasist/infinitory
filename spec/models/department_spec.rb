require 'spec_helper'

describe Department do
  # before :all do
  #   @department = build(:department)
  # end

  let(:department) { build(:department) }

  it 'has a valid department factory' do
    expect(department).to be_valid
  end

  it 'is invalid without a name' do
    expect(build(:department, name: "")).to have(1).errors_on(:name)
  end

  it 'is invalid without an institute' do
    expect(build(:department, institute: nil)).to have(1).errors_on(:institute)
  end

  it { should belong_to(:institute) }
  it { should have_many(:labs) }
  it { should have_many(:users) }
  it { should validate_presence_of(:institute) }
  it { should validate_uniqueness_of(:name).scoped_to(:institute_id).with_message(/A department with that name is already registered at this institute./) }

  it 'is valid with a valid URL' do
    urls = %w[http://www.foo.bar http://research.com www.foo.bar.baz http://bbb.co.uk]
    urls.each do |url|
      valid_url_department = build(:department, url: url)
      expect(valid_url_department).to be_valid
    end
  end

  it 'is invalid with an invalid URL' do
    urls = %w[htp:/www.foo.bar www.research@com www.foo http://sdjfslfjslfjslfsjflskfj]
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