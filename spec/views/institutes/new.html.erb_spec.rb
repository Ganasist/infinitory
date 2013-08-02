require 'spec_helper'

describe "institutes/new" do
  before(:each) do
    assign(:institute, stub_model(Institute,
      :name => "MyString",
      :description => "MyText",
      :latitude => 1.5,
      :longitude => 1.5,
      :city => "MyString",
      :address => "MyString"
    ).as_new_record)
  end

  it "renders new institute form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", institutes_path, "post" do
      assert_select "input#institute_name[name=?]", "institute[name]"
      assert_select "textarea#institute_description[name=?]", "institute[description]"
      assert_select "input#institute_latitude[name=?]", "institute[latitude]"
      assert_select "input#institute_longitude[name=?]", "institute[longitude]"
      assert_select "input#institute_city[name=?]", "institute[city]"
      assert_select "input#institute_address[name=?]", "institute[address]"
    end
  end
end
