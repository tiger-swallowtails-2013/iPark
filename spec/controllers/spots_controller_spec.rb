require 'spec_helper'

describe SpotsController do
  describe "GET signup" do
    it "shows a new spot form" do
      expect(get :new).to render_template :new
    end
  end

  describe "POST signup" do
    before(:each) do
      Spot.destroy_all
      @new_spot = FactoryGirl.build(:spot)
      session[:id] = 1 
    end
    it "does not create a new spot with invalid params" do
      new_spot = post :create, :spot => {street: @new_spot.street, zip_code: nil, price: @new_spot.price, description: @new_spot.description, location_type: @new_spot.location_type}
      expect(Spot.count).to be(0)
    end
    it "renders correct page for invalid spot" do
      expect(post :create, :spot => {street: @new_spot.street, price: @new_spot.price, description: @new_spot.description, location_type: @new_spot.location_type}).to redirect_to new_spot_path
    end
    after(:each) do
      Spot.destroy_all
    end
  end

  describe "GET show" do
    let!(:new_user) { FactoryGirl.create(:user) }
    let(:get_spot) { FactoryGirl.create(:spot) }
    it "shows the spot page" do
      expect(get :show, id: get_spot.id).to render_template :show
    end
  end

  describe "GET index" do
    it "shows index page when logged in" do
      session[:id] = 1
      expect(get :index).to render_template :index
    end
  end

  after(:each) do
    Spot.destroy_all
  end
end
