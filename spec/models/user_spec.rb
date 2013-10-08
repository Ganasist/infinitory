require 'spec_helper'

describe User do

  it 'is invalid without an email address' do
    expect(User.new(email: nil)).to have(1).errors_on(:email)
  end

  it 'is invalid with an existing email address' do
    User.create(email: "test@test.com", role: "group_leader", password: "loislane")
    user = User.new(email: "test@test.com", role: "group_leader", password: "loislane")
    expect(user).to have(1).errors_on(:email)
  end

  it 'is invalid without a password' do
    user = User.new(email: "bob@toner.com", role: "technician")
    expect(user).to have(1).errors_on(:password)
  end

  it 'is invalid without a role' do
    user = User.new(email: "bob@toner.com", password: "loislane")
    expect(user).to have(1).errors_on(:role)
  end

  it 'is valid with an email address, password, role and institute if its role is group leader' do
    user = User.new(email: "test1@test.com", password: "loislane", institute_name: "test", role: "group_leader")
    expect(user).to be_valid
  end

  it 'is valid with an email address, password, and role if its role is not a group leader' do
    user = User.new(email: "test2@test.com",
                       password: "loislane",
                       role: "technician")
    expect(user).to be_valid
  end

  it'has an email that matches "bob@toner.com"' do
    user = User.new(email: "bob@toner.com")
    user.email.should match(/bob@toner.com/)
  end

  it 'changes the number of Users' do
    expect{ User.create(email: "test22@test.com",
                       institute_name: "test",
                       password: "loislane",
                       role: "group_leader") }.to change{ User.count }.by(1)
  end

  describe "when it is a group leader" do
    before :each do
      @gl = User.new(email: "tess3@test.com",
                        institute_name: "test",
                        role: "group_leader",
                        password: "loislane")
    end

    it 'has the same email as the lab if it is a group_leader' do
      @gl.save
      expect(@gl.lab.email).to eql @gl.email
    end

    it 'returns the group leader when gl is called' do
      @gl.save
      user = User.create(email: "tet@test.com", role: "technician", password: "loislane", lab: @gl.lab)
      expect(user.gl).to eql @gl
    end

    it 'returns true when gl is called on a group leader' do
      expect(@gl.gl?).to be_true
    end

    it 'triggers creation of a new lab if it signs up as a group leader' do
      expect{ @gl.save }.to change{ Lab.count }.by(1)
    end
  end

  describe "when it is not group leader" do
    before :each do
      @gl = User.create(email: "test121@test.com", 
                        password: "loislane",
                        institute_name: "test",
                        role: "group_leader")
      @user = User.new(email: "test212@test.com",
                          role: "technician",
                          lab: @gl.lab,
                          password: "loislane")
    end

    it 'does not trigger creation of a new lab if it signs up as a non-group leader' do
      expect{ @user.save }.to change{ Lab.count }.by(0) 
    end

    it 'has the same lab_id as its group leader' do
      expect(@user.lab_id).to eql @gl.lab_id
    end

    it 'returns false when gl is called on a non-group leader' do
      expect(@user.gl?).to be_false
    end
  end

  describe "it returns the fullname" do
    it 'returns the fullname as email if they have not specified a last name' do
      user = User.new(email: "test@test.com", first_name: "Bob")
      expect(user.fullname).to eq "test@test.com"
    end

    it 'returns the fullname as first and last name if they have specified a last name' do
      user = User.new(email: "test@test.com", first_name: "Bob", last_name: "Toner")
      expect(user.fullname).to eq "Bob Toner"
    end
  end  

  it { should respond_to(:reject) }
  it { should respond_to(:approve) }
  it { should respond_to(:retire) }
  it { should respond_to(:confirmed?) }
  it { should respond_to(:location) }
  it { should respond_to(:fullname) }
end
