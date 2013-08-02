require 'spec_helper'

describe "departments/edit" do
  before(:each) do
    @department = assign(:department, stub_model(Department,
      :name => "MyString",
      :institute_id => 1,
      :address => "MyString",
      :longitude => 1.5,
      :latitude => 1.5
    ))
  end

  it "renders the edit department form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", department_path(@department), "post" do
      assert_select "input#department_name[name=?]", "department[name]"
      assert_select "input#department_institute_id[name=?]", "department[institute_id]"
      assert_select "input#department_address[name=?]", "department[address]"
      assert_select "input#department_longitude[name=?]", "department[longitude]"
      assert_select "input#department_latitude[name=?]", "department[latitude]"
    end
  end
end
