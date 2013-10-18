require 'spec_helper'

describe SpotsController do
  describe "GET signup" do
    it "shows a new spot form" do
      expect(get :new).to render_template :new
    end
  end

  describe "POST signup" do
    before(:each) do
      @new_spot = FactoryGirl.build(:spot)
    end
    it "creates new spot when given valid params" do
      create_spot = post :create, :spot => {street: @new_spot.street, zip_code: @new_spot.zip_code, price: @new_spot.price, description: @new_spot.description, location_type: @new_spot.location_type}
      expect(Spot.count).to be(1)
    end
    it "renders correct page for new spot" do
      expect(post :create, :spot => {street: @new_spot.street, zip_code: @new_spot.zip_code, price: @new_spot.price, description: @new_spot.description, location_type: @new_spot.location_type}).to render_template :index
    end
    it "does not create a new spot with invalid params" do
      @new_spot = post :create, :spot => {street: @new_spot.street, zip_code: nil, price: @new_spot.price, description: @new_spot.description, location_type: @new_spot.location_type}
      expect(Spot.count).to be(0)
    end
    it "renders correct page for invalid spot" do
      expect(post :create, :spot => {street: @new_spot.street, zip_code: @new_spot.zip_code, price: @new_spot.price, description: @new_spot.description, location_type: @new_spot.location_type}).to render_template :index
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
      expect(get :index).to render_template :index
    end
  end

  describe "POST destroy" do
    before(:each) do
      @destroy_spot = FactoryGirl.create(:spot)
      @destroy_spot2 = FactoryGirl.create(:spot)
    end
    it "destroys spot" do
      @destroy_post = post :destroy, id: @destroy_spot.id
      expect(Spot.count).to be(1)
    end
    it "renders correct page" do
      expect(post :destroy, id: @destroy_spot2.id).to render_template :index
    end
  end

  after(:each) do
    Spot.destroy_all
  end
end
