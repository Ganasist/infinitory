require 'spec_helper'

describe User do
  let(:gl) { build(:admin) }
  let(:user) { build(:user) }

  context 'database columns' do
    expect_it { to have_db_column(:email).of_type(:string).with_options(default: "", null: false) }
    expect_it { to have_db_column(:encrypted_password).of_type(:string).with_options(default: "", null: false) }
    expect_it { to have_db_column(:reset_password_token).of_type(:string) }
    expect_it { to have_db_column(:reset_password_sent_at).of_type(:datetime) }
    expect_it { to have_db_column(:remember_created_at).of_type(:datetime) }
    expect_it { to have_db_column(:sign_in_count).of_type(:integer).with_options(default: 0) }
    expect_it { to have_db_column(:current_sign_in_at).of_type(:datetime) }
    expect_it { to have_db_column(:last_sign_in_at).of_type(:datetime) }
    expect_it { to have_db_column(:current_sign_in_ip).of_type(:string) }
    expect_it { to have_db_column(:last_sign_in_ip).of_type(:string) }
    expect_it { to have_db_column(:confirmation_token).of_type(:string) }
    expect_it { to have_db_column(:confirmed_at).of_type(:datetime) }
    expect_it { to have_db_column(:confirmation_sent_at).of_type(:datetime) }
    expect_it { to have_db_column(:unconfirmed_email).of_type(:string) }
    expect_it { to have_db_column(:created_at).of_type(:datetime) }
    expect_it { to have_db_column(:updated_at).of_type(:datetime) }
    expect_it { to have_db_column(:lab_id).of_type(:integer) }
    expect_it { to have_db_column(:first_name).of_type(:string) }
    expect_it { to have_db_column(:last_name).of_type(:string) }
    expect_it { to have_db_column(:role).of_type(:string) }
    expect_it { to have_db_column(:institute_id).of_type(:integer) }
    expect_it { to have_db_column(:department_id).of_type(:integer) }
    expect_it { to have_db_column(:approved).of_type(:boolean).with_options(default: false, null: false) }
    expect_it { to have_db_column(:joined).of_type(:datetime) }
    expect_it { to have_db_column(:slug).of_type(:string) }
    expect_it { to have_db_column(:invitation_token).of_type(:string) }
    expect_it { to have_db_column(:invitation_created_at).of_type(:datetime) }
    expect_it { to have_db_column(:invitation_sent_at).of_type(:datetime) }
    expect_it { to have_db_column(:invitation_accepted_at).of_type(:datetime) }
    expect_it { to have_db_column(:invitation_limit).of_type(:integer) }
    expect_it { to have_db_column(:invited_by_id).of_type(:integer) }
    expect_it { to have_db_column(:invited_by_type).of_type(:string) }
    expect_it { to have_db_column(:sash_id).of_type(:integer) }
    expect_it { to have_db_column(:level).of_type(:integer).with_options(default: 0) }
    expect_it { to have_db_column(:reagents_count).of_type(:integer).with_options(default: 0) }
    expect_it { to have_db_column(:devices_count).of_type(:integer).with_options(default: 0) }
    expect_it { to have_db_column(:icon_file_name).of_type(:string) }
    expect_it { to have_db_column(:icon_content_type).of_type(:string) }
    expect_it { to have_db_column(:icon_file_size).of_type(:integer) }
    expect_it { to have_db_column(:icon_updated_at).of_type(:datetime) }
    expect_it { to have_db_column(:twitter_url).of_type(:string) }
    expect_it { to have_db_column(:facebook_url).of_type(:string) }
    expect_it { to have_db_column(:linkedin_url).of_type(:string) }
    expect_it { to have_db_column(:pdf_file_name).of_type(:string) }
    expect_it { to have_db_column(:pdf_content_type).of_type(:string) }
    expect_it { to have_db_column(:pdf_file_size).of_type(:integer) }
    expect_it { to have_db_column(:pdf_updated_at).of_type(:datetime) }
    expect_it { to have_db_column(:icon_processing).of_type(:boolean) }
    expect_it { to have_db_column(:xing_url).of_type(:string) }
    expect_it { to have_db_column(:daily_points).of_type(:integer).with_options(default: 0) }
    expect_it { to have_db_column(:bookings_count).of_type(:integer).with_options(default: 0) }
    expect_it { to have_db_column(:state).of_type(:string) }
    expect_it { to have_db_column(:super_admin).of_type(:boolean).with_options(default: false) }
  end

  context 'database indexes' do
    expect_it { to have_db_index(:confirmation_token).unique(true) }
    expect_it { to have_db_index(:department_id) }
    expect_it { to have_db_index(:email).unique(true) }
    expect_it { to have_db_index(:institute_id) }
    expect_it { to have_db_index(:invitation_token).unique(true) }
    expect_it { to have_db_index(:invited_by_id) }
    expect_it { to have_db_index(:lab_id) }
    expect_it { to have_db_index(:reset_password_token).unique(true) }
    expect_it { to have_db_index(:slug).unique(true) }
  end
  context 'relationships' do
    expect_it { to belong_to(:lab).touch.counter_cache }
    expect_it { to belong_to(:department).touch.counter_cache }
    expect_it { to belong_to(:institute).touch.counter_cache }
    expect_it { to have_many(:ownerships).dependent(:destroy) }
    expect_it { to have_many(:reagents).through(:ownerships) }
    expect_it { to have_many(:device_ownerships).through(:ownerships).class_name('Device') }
    expect_it { to have_many(:bookings).dependent(:destroy) }
    expect_it { to have_many(:device_bookings).through(:bookings).class_name('Device') }
  end

  context 'validations' do
    expect_it { to validate_presence_of(:role) }
    expect_it { to validate_presence_of(:email) }
    expect_it { to validate_uniqueness_of(:email) }
    expect_it { to validate_acceptance_of(:terms) }
    expect_it { to validate_presence_of(:password) }
    expect_it { to validate_confirmation_of(:password) }
    expect_it { to ensure_length_of(:password).is_at_least(8).is_at_most(128) }
    expect_it { to ensure_inclusion_of(:role).in_array(%w[lab_manager research_associate postdoctoral_researcher 
                                                       doctoral_candidate master's_student project_student technician other]) }
    expect_it { to allow_value('http://foo.com', 'http://bar.com/baz').for(:linkedin_url) }
    expect_it { to allow_value('http://foo.com', 'http://bar.com/baz').for(:xing_url) }
    expect_it { to allow_value('http://foo.com', 'http://bar.com/baz').for(:twitter_url) }
    expect_it { to allow_value('http://foo.com', 'http://bar.com/baz').for(:facebook_url) }
    expect_it { to_not allow_value('htp://foo.com', 'http://barcom/baz').for(:linkedin_url) }
    expect_it { to_not allow_value('htp://foo.com', 'http://barcom/baz').for(:xing_url) }
    expect_it { to_not allow_value('htp://foo.com', 'http://barcom/baz').for(:twitter_url) }
    expect_it { to_not allow_value('htp://foo.com', 'http://barcom/baz').for(:facebook_url) }
  end

  context 'methods' do

  end

  it 'is invalid without an email address' do
    expect(build(:user, email: "")).to have(1).errors_on(:email)
  end

  it 'is invalid without a password' do
    user = build(:user, password: "")
    expect(user).to have(1).errors_on(:password)
  end

  it 'is invalid without a role' do
    expect(build(:user, role: "")).to have(2).errors_on(:role)
  end

  it 'is invalid with an unauthorized role' do
    roles = %w[labmanager mastersstudent phdCandidate]
    roles.each do |role|
      invalid_user_role = build(:user, lab: gl.lab, role: role)
      expect(invalid_user_role).to have(1).errors_on(:role)
    end
    expect(build(:user, role: "")).to have(2).errors_on(:role)
  end

  it 'is valid with a valid email address' do
    addresses = %w[user@foo.com user_@_foo.org example@foo.com]
    addresses.each do |address|
      valid_email_user = build(:user, email: address, lab: gl.lab)
      expect(valid_email_user).to be_valid
    end
  end

  it 'is invalid with an invalid email address' do
    addresses = %w[user@foo,com user_at_foo.org example@foo.]
    addresses.each do |address|
      invalid_email_user = build(:user, email: address)
      expect(invalid_email_user).to have(1).errors_on(:email)
    end
  end

  it 'gets sent a confirmation email' do
    # expect { gl.save }.to change(Devise::Async::Backend::Sidekiq.jobs, :size).by(1)
    gl.save
    open_last_email.should be_delivered_to gl.email
    open_last_email.should have_subject "Confirmation instructions"
  end

  it 'has a fullname equal to email initially' do
    expect(gl.fullname).to eql gl.email
  end

  it 'should respond to lab_email' do
    user { should respond_to(:lab_email) }
  end

  it 'is not approved until their lab approves them' do
    user.save
    expect(user.approved?).to be_falsey
  end

  it 'is valid without a lab if it is not a new account' do
    user = create(:user)
    expect(user).to be_valid
  end

  it'has an email that matches "bob@toner.com"' do
    user = build(:user, email: 'bob@toner.com')
    user.email.should match(/bob@toner.com/)
  end

  it 'changes the number of Users' do
    user = build(:user, lab: gl.lab)
    expect { user.save }.to change { User.count }.by(1)
  end

  describe 'when it is a group leader' do
    xit 'changes the number of Labs when it is created' do
      gl = build(:admin)
      expect { gl.save }.to change { Lab.count }.by(1)
    end

    it 'returns the gl when gl is called on a gl with a Lab' do
      user = create(:user, lab: gl.lab)
      expect(user.gl) =~ gl
    end

    it 'is valid without a lab if it is not a new account' do
      gl.lab = nil
      gl.save
      expect(gl).to be_valid
    end

    it 'returns a generic message when the gl method is called on a user without a Lab' do
      user = create(:user, lab: gl.lab)
      user.lab = nil
      expect(user.gl).to eql "#{user.fullname} has no group leader"
    end

    it 'returns true when gl is called on a group leader' do
      expect(gl.gl?).to be_truthy
    end
  end

  describe 'when it is not group leader' do
    before :each do
      user = build(:user, role: 'technician', lab: gl.lab)
    end

    it 'has the same lab_id as its group leader' do
      expect(user.lab).to eql gl.lab
    end

    it 'returns false when gl? is called' do
      expect(user.gl?).to be_falsey
    end
  end

  it { should respond_to(:fullname) }
  describe 'it returns the fullname' do
    it 'returns the fullname as email if they have not specified a first and last name' do
      gl.first_name = "Bob"
      expect(gl.fullname).to eq gl.email
    end

    it 'returns the fullname as first and last name if they have specified a last name' do
      user = build(:user, first_name: 'Bob', last_name: 'Toner')
      expect(user.fullname).to eq 'Bob Toner'
    end
  end

  it { should respond_to(:reject) }
  it { should respond_to(:retire) }
  it { should respond_to(:confirmed?) }
  it { should respond_to(:location) }
end
