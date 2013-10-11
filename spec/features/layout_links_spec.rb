require 'spec_helper'

describe "LayoutLinks" do
  
  it "should have the right title" do
    get '/'
    response.body.should have_title("Infinitory")
  end

  it "should have a sign-up link" do
    get '/'
    response.body.should have_link("Sign-up")
  end

  it "should have a register link" do
    get '/'
    response.body.should have_link("SIGN-IN")
  end

  it "should have the right title" do
    get '/'
    response.body.should have_content("Sign-up")
  end

  it "should have the right title" do
    get '/splash'
    response.body.should have_content("Infinitory")
  end

  it "should have the right content" do
    get '/privacy'
    response.body.should have_content("Privacy Policy")
  end

end
