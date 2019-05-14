require "rails_helper"

RSpec.describe ObrasController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/obras").to route_to("obras#index")
    end

    it "routes to #new" do
      expect(:get => "/obras/new").to route_to("obras#new")
    end

    it "routes to #show" do
      expect(:get => "/obras/1").to route_to("obras#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/obras/1/edit").to route_to("obras#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/obras").to route_to("obras#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/obras/1").to route_to("obras#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/obras/1").to route_to("obras#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/obras/1").to route_to("obras#destroy", :id => "1")
    end

  end
end
