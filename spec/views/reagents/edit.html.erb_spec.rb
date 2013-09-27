require 'spec_helper'

describe "reagents/edit" do
  before(:each) do
    @reagent = assign(:reagent, stub_model(Reagent,
      :name => "MyString",
      :category => "MyString",
      :owner => "MyString",
      :location => "MyString",
      :price => "9.99",
      :serial => "MyString",
      :quantity => "MyString",
      :properties => ""
    ))
  end

  it "renders the edit reagent form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", reagent_path(@reagent), "post" do
      assert_select "input#reagent_name[name=?]", "reagent[name]"
      assert_select "input#reagent_category[name=?]", "reagent[category]"
      assert_select "input#reagent_owner[name=?]", "reagent[owner]"
      assert_select "input#reagent_location[name=?]", "reagent[location]"
      assert_select "input#reagent_price[name=?]", "reagent[price]"
      assert_select "input#reagent_serial[name=?]", "reagent[serial]"
      assert_select "input#reagent_quantity[name=?]", "reagent[quantity]"
      assert_select "input#reagent_properties[name=?]", "reagent[properties]"
    end
  end
end
