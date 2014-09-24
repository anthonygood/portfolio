require 'rails_helper'

RSpec.describe EtchingsController, :type => :controller do

  describe "GET index" do
    let(:subject){ EtchingsController.new }

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "retrieves all etchings" do
      etchings = Etching.create(title: "foo")
      get :index
      expect(assigns(:etchings)).to eq [etchings]
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET show" do
    it "retrieves the etching specified in the param" do
      etching = Etching.create(title: "foo")
      get :show, id: etching

      expect(assigns(:etching)).to eq etching
    end
  end

end
