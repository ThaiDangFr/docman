require "rails_helper"

RSpec.describe SocietesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/societes").to route_to("societes#index")
    end

    it "routes to #new" do
      expect(:get => "/societes/new").to route_to("societes#new")
    end

    it "routes to #show" do
      expect(:get => "/societes/1").to route_to("societes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/societes/1/edit").to route_to("societes#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/societes").to route_to("societes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/societes/1").to route_to("societes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/societes/1").to route_to("societes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/societes/1").to route_to("societes#destroy", :id => "1")
    end

  end
end
