require 'spec_helper'

describe Lab do
  it 'is invalid without an email address' do
  	institute = Institute.new
  	lab = Lab.new(institute: institute)
  	expect(lab).to_not be_valid
  end

  it 'is invalid without an institute' do
  	lab = Lab.new(email: "lab@lab.com")
  	expect(lab).to_not be_valid
  end

  it 'is invalid without a group leader'

  it 'is invalid with more than one group leader'

  it 'is valid with one group leader'

end