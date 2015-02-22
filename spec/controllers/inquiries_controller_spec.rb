require 'rails_helper'

RSpec.describe InquiriesController, :type => :controller do

  describe "#create" do
    it "returns http success" do
      post :create
      expect(response).to have_http_status(:success)
    end

    it "creates an inquiry record" do
      expect{ post :create, name: "Bill Good" }.to change{Inquiry.count}.by 1
    end
  end
end
