require "rails_helper"

RSpec.describe EditorasController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/editoras").to route_to("editoras#index")
    end

    it "routes to #new" do
      expect(:get => "/editoras/new").to route_to("editoras#new")
    end

    it "routes to #show" do
      expect(:get => "/editoras/1").to route_to("editoras#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/editoras/1/edit").to route_to("editoras#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/editoras").to route_to("editoras#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/editoras/1").to route_to("editoras#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/editoras/1").to route_to("editoras#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/editoras/1").to route_to("editoras#destroy", :id => "1")
    end

  end
end
