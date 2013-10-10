require 'spec_helper'

describe User do

  it 'has a valid user factory' do
    expect(build(:user)).to be_valid
  end

  it 'has a valid admin factory' do
    expect(build(:admin)).to be_valid
  end

  it 'is invalid without an email address' do
    expect(build(:user, email: nil)).to have(1).errors_on(:email)
  end

  it 'is invalid with an existing email address' do
    create(:user, email: 'bob@toner.com')
    user = build(:user, email: 'bob@toner.com')
    expect(user).to have(1).errors_on(:email)
  end

  it 'is invalid without a password' do
    user = build(:user, password: nil)
    expect(user).to have(1).errors_on(:password)
  end

  it 'is invalid without a role' do
    expect(build(:user, role: nil)).to have(1).errors_on(:role)
  end

  it 'is valid with an email address, password, role and institute if its role is group leader' do
    expect(User.create(email: 'factory@test.com',
                       institute_name: 'University One',
                       password: 'loislane',
                       role: 'group_leader')).to be_valid
  end

  it 'gets sent a confirmation email' do
    User.create(email: 'factory@test.com',
                       institute_name: 'University One',
                       password: 'loislane',
                       role: 'group_leader')
    open_last_email.should be_delivered_to 'factory@test.com'
  end

  it 'is valid with an email address, password, and role if its role is not a group leader' do
    expect(create(:user)).to be_valid
  end

  it'has an email that matches "bob@toner.com"' do
    user = build(:user, email: 'bob@toner.com')
    user.email.should match(/bob@toner.com/)
  end

  it 'changes the number of Users' do
    expect{ User.create(email: 'test22@test.com',
                       institute_name: 'University One',
                       password: 'loislane',
                       role: 'group_leader') }.to change{ User.count }.by(1)
  end

  it 'returns the group leader when the gl method is called' do
    @gl = User.create(email: 'factory@test.com',
                        institute_name: 'University One',
                        role: 'group_leader',
                        password: 'loislane')
    user = create(:user, role: 'technician', lab: @gl.lab)
    expect(user.gl).to eql @gl
  end

  describe 'when it is a group leader' do
    before :each do
      @gl = User.new(email: 'factory@test.com',
                        institute_name: 'University One',
                        role: 'group_leader',
                        password: 'loislane')
    end

    it 'has the same email as the lab' do
      @gl.save
      expect(@gl.lab.email).to eql @gl.email
    end

    it 'triggers creation of a new lab if it signs up' do
      expect{ @gl.save }.to change{ Lab.count }.by(1)
    end

    it 'returns true when gl is called on a group leader' do
      expect(@gl.gl?).to be_true
    end
  end

  describe 'when it is not group leader' do
    before :each do
      @gl = User.create(email: 'factory@test.com',
                        institute_name: 'University One',
                        role: 'group_leader',
                        password: 'loislane')
      @user = build(:user, role: 'technician', lab: @gl.lab)
    end

    it 'does not trigger creation of a new lab if it signs up' do
      expect{ @user.save }.to change{ Lab.count }.by(0) 
    end

    it 'has the same lab_id as its group leader' do
      expect(@user.lab_id).to eql @gl.lab_id
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
