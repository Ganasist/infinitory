require 'spec_helper'

describe "labs/new" do
  before(:each) do
    assign(:lab, stub_model(Lab,
      :department_id => 1,
      :institute_id => 1,
      :group_leader => "MyString",
      :group_leader_email => "MyString"
    ).as_new_record)
  end

  it "renders new lab form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", labs_path, "post" do
      assert_select "input#lab_department_id[name=?]", "lab[department_id]"
      assert_select "input#lab_institute_id[name=?]", "lab[institute_id]"
      assert_select "input#lab_group_leader[name=?]", "lab[group_leader]"
      assert_select "input#lab_group_leader_email[name=?]", "lab[group_leader_email]"
    end
  end
end
