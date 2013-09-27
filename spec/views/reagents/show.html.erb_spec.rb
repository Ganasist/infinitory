require 'spec_helper'

describe "reagents/show" do
  before(:each) do
    @reagent = assign(:reagent, stub_model(Reagent,
      :name => "Name",
      :category => "Category",
      :owner => "Owner",
      :location => "Location",
      :price => "9.99",
      :serial => "Serial",
      :quantity => "Quantity",
      :properties => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Category/)
    rendered.should match(/Owner/)
    rendered.should match(/Location/)
    rendered.should match(/9.99/)
    rendered.should match(/Serial/)
    rendered.should match(/Quantity/)
    rendered.should match(//)
  end
end
