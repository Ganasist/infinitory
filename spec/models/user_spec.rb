require 'spec_helper'

describe User do
  it 'is invalid without an email address' do
  	user = User.new
  	subject.should_not be_valid
  end

  it 'is invalid without a password' do
  	user = User.new(email: "bob@toner.com", role: "technician")
  	user.should_not be_valid
  end

  it 'is invalid without a role' do
  	user = User.new(email: "bob@toner.com", password: "loislane")
  	user.should_not be_valid
  end

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

  it 'has the same email as the lab if it is a group leader'
  
  it "belongs to a lab" do
  	lab = Lab.new(email: "test@test.com")
  	user = User.new(email: "bob@bob.com", lab: lab)
  	user.lab.email.should == lab.email
  end

  it "belongs to an institute" do
  	lab = Lab.new(email: "test@test.com", institute_id: 77)
  	user = User.new(email: "bob@bob.com", lab: lab)
  	user.lab.institute_id.should == lab.institute_id
  end

  it "changes the number of Users" do
  	institute = Institute.new
  	user = User.new(email: "bob@toner.com", role: "lab_manager", password: "loislane", lab: Lab.new(email: "big@test.com", institute: institute))
  	expect { user.save! }.to change { User.count }.by(1)
  end
end
