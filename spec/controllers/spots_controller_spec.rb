require 'spec_helper'

describe SpotsController do
  describe "GET signup" do
    it "shows a new spot form" do
      expect(get :new).to render_template :new
    end
  end

  describe "POST signup" do
    let(:new_spot) { FactoryGirl.build(:spot) }
    it "creates new spot when given valid params" do
      expect(post :create, :spot => {street: new_spot.street, zip_code: new_spot.zip_code, price: new_spot.price, description: new_spot.description, type: new_spot.type}).to change(Spot, :count).by(1)
    end
    it "renders correct page for new spot" do
      expect(post :create, :spot => {street: new_spot.street, zip_code: new_spot.zip_code, price: new_spot.price, description: new_spot.description, type: new_spot.type}).to render_template :index
    end
    it "does not create a new spot with invalid params" do
      expect(post :create, :spot => {street: new_spot.street, zip_code: new_spot.zip_code, price: new_spot.price, description: new_spot.description, type: new_spot.type}).not_to change(Spot, :count)
    end
    it "renders correct page for invalid spot" do
      expect(post :create, :spot => {street: new_spot.street, zip_code: new_spot.zip_code, price: new_spot.price, description: new_spot.description, type: new_spot.type}).to render_template :index
    end
  end

  describe "GET show" do
    let(:get_spot) {FactoryGirl.create(:spot)}
    it "shows the spot page" do
      expect(get :show, id: get_spot.id).to render_template :show
    end
  end

  describe "GET index" do
    it "shows index page" do
      expect(get :index).to render_template :index
    end
  end

  describe "POST destroy" do
    let(:destroy_spot) {FactoryGirl.create(:spot)}
    let(:destroy_spot2) {FactoryGirl.create(:spot)}
    it "destroys spot" do
      expect(post :destroy, id: destroy_spot.id).to change(Spot, :count).by(1)
    end
    it "renders correct page" do
      expect(post :destroy, id: destroy_spot2.id).to render_template :index
    end
  end
end
