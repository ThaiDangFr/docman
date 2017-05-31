require "rails_helper"

RSpec.describe ReunionsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/reunions").to route_to("reunions#index")
    end

    it "routes to #new" do
      expect(:get => "/reunions/new").to route_to("reunions#new")
    end

    it "routes to #show" do
      expect(:get => "/reunions/1").to route_to("reunions#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/reunions/1/edit").to route_to("reunions#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/reunions").to route_to("reunions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/reunions/1").to route_to("reunions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/reunions/1").to route_to("reunions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/reunions/1").to route_to("reunions#destroy", :id => "1")
    end

  end
end
