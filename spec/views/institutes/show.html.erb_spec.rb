require 'spec_helper'

describe "institutes/show" do
  before(:each) do
    @institute = assign(:institute, stub_model(Institute,
      :name => "Name",
      :description => "MyText",
      :latitude => 1.5,
      :longitude => 1.5,
      :city => "City",
      :address => "Address"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/City/)
    rendered.should match(/Address/)
  end
end
