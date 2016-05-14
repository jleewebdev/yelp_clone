require "spec_helper"

describe BusinessesController do

  describe "GET index" do
    it "sets @businesses" do
      business1 = Fabricate(:business)
      business2 = Fabricate(:business)
      get :index
      expect(assigns(:businesses)).to match_array([business1, business2])
    end
  end


  describe "GET new" do

    context "logged in user" do
      it "set @business" do
        alice = Fabricate(:user)
        session[:user_id] = alice.id
        get :new
        expect(assigns(:business)).to be_instance_of(Business)
      end

    end

    context "user not logged in" do

      it "redirects to log in page" do
        get :new
        expect(response).to redirect_to root_path
      end

      it "sets the flash message" do
        get :new
        expect(flash[:error]).not_to be_blank
      end

    end

  end

  describe "POST new" do

    context "logged in user" do
      it "creates the business" do
        post :create, business: Fabricate.attributes_for(:business)
        expect(Business.count).to eq(1)
      end

      it "redirects to the created business's page" do
        business_params = Fabricate.attributes_for(:business)
        post :create, business: business_params
        expect(response).to redirect_to businesses_path(Business.first)
      end
    end
  end


  describe "GET show" do
    it "sets @business" do
      business = Fabricate(:business, id:1)
      get :show, id: 1
      expect(assigns(:business)).to be_instance_of(Business)
    end
  end
  
end 