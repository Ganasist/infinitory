require 'spec_helper'

describe "Bookings" do
  describe "GET /bookings" do
    it "works! (now write some real specs)" do
      get bookings_path
      expect(response.status).to be(200)
    end
  end
end
