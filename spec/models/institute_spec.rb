require 'spec_helper'

describe Institute do
  let(:institute) { build(:institute) }
  
  context 'relationships' do
    it { should have_many(:departments) }
    it { should have_many(:labs) }
    it { should have_many(:users) }
  end

  context 'validations' do  
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive.scoped_to(:address).with_message(/This institute is already registered at that address/) }
  end

  context 'database columns' do
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:latitude).of_type(:float) }
    it { should have_db_column(:longitude).of_type(:float) }
    it { should have_db_column(:address).of_type(:text) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
    it { should have_db_column(:alternate_name).of_type(:string) }
    it { should have_db_column(:country).of_type(:string) }
    it { should have_db_column(:url).of_type(:string) }
    it { should have_db_column(:acronym).of_type(:string) }
    it { should have_db_column(:slug).of_type(:string) }
    it { should have_db_column(:icon).of_type(:string) }
    it { should have_db_column(:icon_processing).of_type(:boolean) }
    it { should have_db_column(:users_count).of_type(:integer).with_options(default: 0) }
    it { should have_db_column(:labs_count).of_type(:integer).with_options(default: 0) }
    it { should have_db_column(:email).of_type(:string) }
  end

  context 'database indexes' do
    it { should have_db_index(:email) }
    it { should have_db_index(:slug).unique(true) }
    it { should have_db_index([:latitude, :longitude]) }
  end

  it 'has a valid institute factory' do
    expect(institute).to be_valid
  end

  it 'is invalid without a name' do
    expect(build(:institute, name: "")).to have(1).errors_on(:name)
  end

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