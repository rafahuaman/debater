require "spec_helper"

describe ArgumentPostsController do
  describe "routing" do

    it "routes to #index" do
      get("/argument_posts").should route_to("argument_posts#index")
    end

    it "routes to #new" do
      get("/argument_posts/new").should route_to("argument_posts#new")
    end

    it "routes to #show" do
      get("/argument_posts/1").should route_to("argument_posts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/argument_posts/1/edit").should route_to("argument_posts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/argument_posts").should route_to("argument_posts#create")
    end

    it "routes to #update" do
      put("/argument_posts/1").should route_to("argument_posts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/argument_posts/1").should route_to("argument_posts#destroy", :id => "1")
    end

  end
end
