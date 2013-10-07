require 'spec_helper'

describe User do

  it 'is valid with an email address, password, role and institute if its role is group leader' do
    user = User.new(email: "test@test.com", institute_id: 1, role: "group_leader", password: "loislane")
    lab = Lab.new(email: "gl.email", institute_id: 1)
    expect(user).to be_valid
  end

  it 'is valid with an email address, password, role and gl email address if its role is not group leader' do

  end


  it 'is invalid without an email address' do
  	user = User.new
  	expect(user).to_not be_valid
  end

  it 'is invalid without a password' do
  	user = User.new(email: "bob@toner.com", role: "technician")
  	user.should_not be_valid
  end

  it 'is invalid without a role' do
  	user = User.new(email: "bob@toner.com", password: "loislane")
  	user.should_not be_valid
  end

  it 'is invalid with a duplicate email address'  
  it 'has the same email as the lab if it is a group leader'  
  it 'belongs to a lab'
  it 'belongs to an institute'
  it 'changes the number of Users'
  it 'returns a contacts full name as a string'
  it 'triggers creation of a new lab if its role is Group Leader'

  it { should respond_to(:reject) }
  it { should respond_to(:approve) }
  it { should respond_to(:retire) }
  it { should respond_to(:confirmed?) }
  it { should respond_to(:location) }
  it { should respond_to(:fullname) }

  it'has an email that matches "bob@toner.com"' do
  	user = User.new(email: "bob@toner.com")
  	user.email.should match(/bob@toner.com/)
  end
end
