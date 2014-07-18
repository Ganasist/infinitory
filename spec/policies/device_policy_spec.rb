require 'spec_helper'

describe DevicePolicy do
  subject { DevicePolicy.new(user, device) }

  let(:gl) { create(:admin) }
  let(:lab) { gl.lab }

  let(:device) { FactoryGirl.create(:device) }
  device.lab = lab

  context "for a user" do
    let(:user) { FactoryGirl.create(:user) }
    
    user.lab = lab

    it { should permit(:show)    }
    it { should permit(:create)  }
    it { should permit(:new)     }
    it { should permit(:update)  }
    it { should permit(:edit)    }
    it { should permit(:destroy) }
  end
end