require 'spec_helper'

describe Institute do
  # before :all do
  #   @department = build(:department)
  # end

  let(:institute) { build(:institute) }

  it 'has a valid institute factory' do
    expect(institute).to be_valid
  end

  it 'is invalid without a name' do
    expect(build(:institute, name: "")).to have(1).errors_on(:name)
  end

  it { should have_many(:departments) }
  it { should have_many(:labs) }
  it { should have_many(:users) }  
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).case_insensitive.scoped_to(:address).with_message(/This institute is already registered at that address/) }
  
  it { should have_db_index(:slug).unique(true) }
  it { should have_db_index([:latitude, :longitude]) }

  it 'is valid with a valid URL' do
    urls = %w[http://www.foo.bar http://research.com www.foo.bar.baz http://bbb.co.uk]
    urls.each do |url|
      valid_url_institute = build(:institute, url: url)
      expect(valid_url_institute).to have(0).errors_on(:url)
    end
  end

  it 'is invalid with an invalid URL' do
    urls = %w[htp:/www.foo.bar lkjlkjl www.research@com http://sdjfslfjslfjslfsjflskfj]
    urls.each do |url|
      valid_url_institute = build(:institute, url: url)
      expect(valid_url_institute).to have(1).errors_on(:url)
    end
  end
end