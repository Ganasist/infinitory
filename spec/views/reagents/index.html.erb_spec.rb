require 'spec_helper'

describe "reagents/index" do
  before(:each) do
    assign(:reagents, [
      stub_model(Reagent,
        :name => "Name",
        :category => "Category",
        :owner => "Owner",
        :location => "Location",
        :price => "9.99",
        :serial => "Serial",
        :quantity => "Quantity",
        :properties => ""
      ),
      stub_model(Reagent,
        :name => "Name",
        :category => "Category",
        :owner => "Owner",
        :location => "Location",
        :price => "9.99",
        :serial => "Serial",
        :quantity => "Quantity",
        :properties => ""
      )
    ])
  end

  it "renders a list of reagents" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Category".to_s, :count => 2
    assert_select "tr>td", :text => "Owner".to_s, :count => 2
    assert_select "tr>td", :text => "Location".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Serial".to_s, :count => 2
    assert_select "tr>td", :text => "Quantity".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
