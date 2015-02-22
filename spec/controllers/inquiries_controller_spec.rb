require 'rails_helper'

RSpec.describe InquiriesController, :type => :controller do

  describe "#create" do
    let(:inquiry) { post :create, name: "Bill Good"  }
    before do
      allow(InquiryMailer).to receive(:notification).and_call_original
    end
    it "returns http success" do
      post :create
      expect(response).to have_http_status(:success)
    end

    it "creates an inquiry record" do
      expect{ inquiry }.to change{Inquiry.count}.by 1
    end

    it "sends us a notification" do
      expect(InquiryMailer).to receive(:notification)

      inquiry
    end
  end
end
