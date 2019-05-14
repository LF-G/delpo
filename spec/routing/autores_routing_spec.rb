require "rails_helper"

RSpec.describe AutoresController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/autores").to route_to("autores#index")
    end

    it "routes to #new" do
      expect(:get => "/autores/new").to route_to("autores#new")
    end

    it "routes to #show" do
      expect(:get => "/autores/1").to route_to("autores#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/autores/1/edit").to route_to("autores#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/autores").to route_to("autores#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/autores/1").to route_to("autores#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/autores/1").to route_to("autores#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/autores/1").to route_to("autores#destroy", :id => "1")
    end

  end
end
