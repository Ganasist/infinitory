require 'spec_helper'

describe User do
  before :each do
    @gl = build(:admin)
    lab = Lab.create(email: @gl.email, institute: @gl.institute)
    @gl.lab = lab
    @gl.save
  end

  it 'has a valid user factory' do
    expect(create(:user, lab: @gl.lab)).to be_valid
  end

  it 'has a valid admin factory' do
    expect( @gl ).to be_valid
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
    user = build(:admin, email: @gl.email)
    expect(user).to have(1).errors_on(:email)
  end

  it 'is valid with a valid email address' do
    addresses = %w[user@foo.com user_@_foo.org example@foo.com]
    addresses.each do |address|
      valid_email_user = build(:user, email: address, lab: @gl.lab)
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
    expect(@gl).to be_valid
  end

  it 'gets sent a confirmation email' do
    open_last_email.should be_delivered_to @gl.email
  end

  it 'has a fullname equal to email initially' do
    expect(@gl.fullname).to eql @gl.email
  end

  it 'is not valid without a lab if it is a new account' do
    invalid_user = build(:user, lab: nil)
    expect(invalid_user).to_not be_valid
  end

  it 'is valid without a lab if it is not a new account' do
    user = create(:user, lab: @gl.lab)
    user.confirmed? == true
    user.lab = nil
    user.save
    expect(user).to be_valid
  end

  it'has an email that matches "bob@toner.com"' do
    user = build(:user, email: 'bob@toner.com')
    user.email.should match(/bob@toner.com/)
  end

  it 'changes the number of Users' do
    user = build(:user, lab: @gl.lab)
    expect{ user.save }.to change{ User.count }.by(1)
  end

  it 'returns the gl when gl is called on a gl with a Lab' do
    user = create(:user, lab: @gl.lab)
    expect(user.gl) =~ @gl
  end

  it 'returns a generic message when the gl method is called on a user without a Lab' do
    user = create(:user, lab: @gl.lab)
    user.lab = nil
    expect(user.gl).to eql "#{user.fullname} has no group leader"
  end

  it 'returns true when gl is called on a group leader' do
    expect(@gl.gl?).to be_true
  end

  describe 'when it is not group leader' do
    before :each do
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
    it 'returns the fullname as email if they have not specified a first and last name' do
      @gl.first_name = "Bob"
      expect(@gl.fullname).to eq @gl.email
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
