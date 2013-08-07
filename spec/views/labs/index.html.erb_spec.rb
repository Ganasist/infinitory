require 'spec_helper'

describe "labs/index" do
  before(:each) do
    assign(:labs, [
      stub_model(Lab,
        :department_id => 1,
        :institute_id => 2,
        :group_leader => "Group Leader",
        :group_leader_email => "Group Leader Email"
      ),
      stub_model(Lab,
        :department_id => 1,
        :institute_id => 2,
        :group_leader => "Group Leader",
        :group_leader_email => "Group Leader Email"
      )
    ])
  end

  it "renders a list of labs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Group Leader".to_s, :count => 2
    assert_select "tr>td", :text => "Group Leader Email".to_s, :count => 2
  end
end
