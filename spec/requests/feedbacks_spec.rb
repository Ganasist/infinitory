require 'spec_helper'

describe "Feedbacks" do
  describe "GET /feedbacks" do
    it "works! (now write some real specs)" do
      get feedbacks_path
      expect(response.status).to be(200)
    end
  end
end
