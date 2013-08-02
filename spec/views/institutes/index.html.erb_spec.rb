require 'spec_helper'

describe "institutes/index" do
  before(:each) do
    assign(:institutes, [
      stub_model(Institute,
        :name => "Name",
        :description => "MyText",
        :latitude => 1.5,
        :longitude => 1.5,
        :city => "City",
        :address => "Address"
      ),
      stub_model(Institute,
        :name => "Name",
        :description => "MyText",
        :latitude => 1.5,
        :longitude => 1.5,
        :city => "City",
        :address => "Address"
      )
    ])
  end

  it "renders a list of institutes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
  end
end
