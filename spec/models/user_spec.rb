require 'spec_helper'

describe User do

  it 'has a valid user factory' do
    expect(create(:user)).to be_valid
  end

  it 'has a valid admin factory' do
    expect(create(:admin)).to be_valid
  end

  it 'is invalid without an email address' do
    expect(build(:user, email: "")).to have(1).errors_on(:email)
  end

  it 'is invalid without a password' do
    user = build(:user, password: "")
    expect(user).to have(1).errors_on(:password)
  end

  it 'is invalid without a role' do
    expect(build(:user, role: "")).to have(1).errors_on(:role)
  end

  it 'is invalid with an existing email address' do
    create(:user, email: 'bob@toner.com')
    user = build(:user, email: 'bob@toner.com')
    expect(user).to have(1).errors_on(:email)
  end

  it 'is valid with a valid email address' do
    addresses = %w[user@foo.com user_@_foo.org example@foo.com]
    addresses.each do |address|
      valid_email_user = build(:user, email: address)
      expect(valid_email_user).to be_valid
    end
  end

  it 'is invalid with an invalid email address' do
    addresses = %w[user@foo,com user_at_foo.org example@foo.]
    addresses.each do |address|
      invalid_email_user = build(:user, email: address)
      expect(invalid_email_user).to_not be_valid
    end
  end

  it 'is valid with an email address, password, role and institute if its role is group leader' do
    expect(create(:user)).to be_valid
  end

  it 'gets sent a confirmation email' do
    gl = create(:admin)
    open_last_email.should be_delivered_to gl.email
  end

  it 'has a fullname equal to email initially' do
    gl = create(:admin)
    expect(gl.fullname).to eql gl.email
  end

  it 'is valid with an email address, password, and role if its role is not a group leader' do
    expect(create(:user)).to be_valid
  end

  it'has an email that matches "bob@toner.com"' do
    user = build(:user, email: 'bob@toner.com')
    user.email.should match(/bob@toner.com/)
  end

  it 'changes the number of Users' do
    expect{ create(:user) }.to change{ User.count }.by(1)
  end

  describe 'when it is a group leader' do
    before :each do
      @gl = build(:admin)
    end

    it 'returns nil when the gl method is called on a gl without a Lab' do
      @gl.save
      expect(@gl.gl).to eql nil
    end

    it 'returns gl when the gl method is called on a gl with a Lab' do
      lab = Lab.create(email: @gl.email, institute: @gl.institute)
      @gl.lab = lab
      @gl.save
      user = build(:user)
      user.lab = lab
      user.save
      expect(user.gl).to eql @gl
    end

    it 'returns true when gl is called on a group leader' do
      expect(@gl.gl?).to be_true
    end
  end

  describe 'when it is not group leader' do
    before :each do
      @gl = create(:admin)
      @user = build(:user, role: 'technician', lab: @gl.lab)
    end

    it 'has the same lab_id as its group leader' do
      expect(@user.lab).to eql @gl.lab
    end

    it 'returns false when gl? is called' do
      expect(@user.gl?).to be_false
    end
  end

  describe 'it returns the fullname' do
    it 'returns the fullname as email if they have not specified a last name' do
      user = build(:user, first_name: 'Bob')
      expect(user.fullname).to eq user.email
    end

    it 'returns the fullname as first and last name if they have specified a last name' do
      user = build(:user, first_name: 'Bob', last_name: 'Toner')
      expect(user.fullname).to eq 'Bob Toner'
    end
  end  

  it { should respond_to(:reject) }
  it { should respond_to(:approve) }
  it { should respond_to(:retire) }
  it { should respond_to(:confirmed?) }
  it { should respond_to(:location) }
  it { should respond_to(:fullname) }
end
