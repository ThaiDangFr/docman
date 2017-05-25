require "rails_helper"

RSpec.describe DmsessionsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/dmsessions").to route_to("dmsessions#index")
    end

    it "routes to #new" do
      expect(:get => "/dmsessions/new").to route_to("dmsessions#new")
    end

    it "routes to #show" do
      expect(:get => "/dmsessions/1").to route_to("dmsessions#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/dmsessions/1/edit").to route_to("dmsessions#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/dmsessions").to route_to("dmsessions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/dmsessions/1").to route_to("dmsessions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/dmsessions/1").to route_to("dmsessions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/dmsessions/1").to route_to("dmsessions#destroy", :id => "1")
    end

  end
end
