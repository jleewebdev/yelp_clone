require "spec_helper"

describe ReviewsController do

  describe "POST create" do
    context "logged in user" do
      let(:business) { Fabricate(:business) }
      let(:review_params) { Fabricate.attributes_for(:review) }
      let(:alice) { Fabricate(:user) }

      before do
        sign_in(alice)
        post :create, business_id: business.id, review: review_params
      end

      it "creates review" do
        expect(Review.count).to eq(1)
      end

      it "associates review to business" do
        expect(Review.first.business).to eq(business)
      end 

      it "associates review with current_user" do
        expect(Review.first.user.id).to eq(alice.id)
      end

      it "redirects to business page" do
        expect(response).to redirect_to business_path(business)
      end
    end

    it_behaves_like "requires sign in" do
      let(:action) { post :create, business_id: Fabricate(:business).id, review: Fabricate.attributes_for(:review) }
    end

    context "with invalid inputs" do  
      let(:alice) { Fabricate(:user) }
      let(:business) { Fabricate(:business) }

      before do
        sign_in(alice)
        post :create, business_id: business.id, review: {title: "Just an example"}
      end


      it "renders the business new template" do
        expect(response).to render_template "businesses/show"
      end

      it "sets the flash message" do
        expect(flash[:danger]).not_to be_blank
      end
    end
  end

  describe "GET recent" do
    it "sets @reviews" do
      review1 = Fabricate(:review, created_at: 2.days.ago)
      review2 = Fabricate(:review)
      get :recent
      expect(assigns(:reviews)).not_to be_nil

    end
  end

  
end