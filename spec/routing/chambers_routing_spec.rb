require "spec_helper"

describe ChambersController do
  describe "routing" do

    it "routes to #index" do
      get("/chambers").should route_to("chambers#index")
    end

    it "routes to #new" do
      get("/chambers/new").should route_to("chambers#new")
    end

    it "routes to #show" do
      get("/chambers/1").should route_to("chambers#show", :id => "1")
    end

    it "routes to #edit" do
      get("/chambers/1/edit").should route_to("chambers#edit", :id => "1")
    end

    it "routes to #create" do
      post("/chambers").should route_to("chambers#create")
    end

    it "routes to #update" do
      put("/chambers/1").should route_to("chambers#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/chambers/1").should route_to("chambers#destroy", :id => "1")
    end

  end
end
