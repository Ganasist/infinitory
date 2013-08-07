require 'spec_helper'

describe "labs/show" do
  before(:each) do
    @lab = assign(:lab, stub_model(Lab,
      :department_id => 1,
      :institute_id => 2,
      :group_leader => "Group Leader",
      :group_leader_email => "Group Leader Email"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Group Leader/)
    rendered.should match(/Group Leader Email/)
  end
end
