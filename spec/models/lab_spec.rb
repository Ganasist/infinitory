require 'spec_helper'

describe Lab do

  it 'has a valid factory' do
  	expect(create(:lab)).to be_valid
  end

  it 'is invalid without an email address' do
  	expect(build(:lab, email: "")).to have(1).errors_on(:email)
  end

  it 'is invalid without an institute' do
  	expect(build(:lab, institute_name: "")).to have(1).errors_on(:institute)
  end

  it 'is valid with one group leader'

  it 'is invalid without a group leader'
  it 'is invalid with more than one group leader'

  it { should respond_to(:lab_name) }
  it { should respond_to(:lab_email) }
  it { should respond_to(:gl_count) }
  it { should respond_to(:gl) }  
  it { should respond_to(:size) }
  it { should respond_to(:city) }
  it { should respond_to(:location) }

end