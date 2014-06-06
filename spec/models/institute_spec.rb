require 'spec_helper'

describe Institute do
  
  let(:institute) { build_stubbed(:institute) }

  context 'database columns' do
    expect_it { to have_db_column(:name).of_type(:string).with_options(null: false) }
    expect_it { to have_db_column(:address).of_type(:text) }
    expect_it { to have_db_column(:created_at).of_type(:datetime) }
    expect_it { to have_db_column(:updated_at).of_type(:datetime) }
    expect_it { to have_db_column(:alternate_name).of_type(:string) }
    expect_it { to have_db_column(:url).of_type(:string) }
    expect_it { to have_db_column(:acronym).of_type(:string) }
    expect_it { to have_db_column(:slug).of_type(:string) }
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
    expect_it { to have_db_index([:name, :address]).unique(true) }
    expect_it { to have_db_index(:slug).unique(true).unique(true) }
  end

  context 'relationships' do
    expect_it { to have_many(:departments) }
    expect_it { to have_many(:labs) }
    expect_it { to have_many(:users) }
  end

  context 'validations' do  
    expect_it { to validate_presence_of(:name) }
    pending { to validate_uniqueness_of(:name).case_insensitive.scoped_to(:address).with_message(/This institute is already registered at that address/) }
  end
  context 'methods' do

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