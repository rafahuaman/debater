require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe ArgumentPostsController do
  let(:user) { FactoryGirl.create(:user, name: "ArgumentPost")  }
  let(:chamber) { FactoryGirl.create(:chamber)  }
  let(:debate) { FactoryGirl.create(:debate)  }

  # This should return the minimal set of attributes required to create a valid
  # ArgumentPost. As you add validations to ArgumentPost, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { content: "MyText", debate_id: debate.id,
    type: "OriginalPost", position: "affirmative", user_id: user.id } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ArgumentPostsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all argument_posts as @argument_posts" do
      argument_post = ArgumentPost.create! valid_attributes
      get :index, {}, valid_session
      assigns(:argument_posts).should eq([argument_post])
    end
  end

  describe "GET show" do
    it "assigns the requested argument_post as @argument_post" do
      argument_post = ArgumentPost.create! valid_attributes
      get :show, {:id => argument_post.to_param}, valid_session
      assigns(:argument_post).should eq(argument_post)
    end
  end

  describe "GET new" do
    it "assigns a new argument_post as @argument_post" do
      get :new, {}, valid_session
      assigns(:argument_post).should be_a_new(ArgumentPost)
    end
  end

  describe "GET edit" do
    it "assigns the requested argument_post as @argument_post" do
      argument_post = ArgumentPost.create! valid_attributes
      get :edit, {:id => argument_post.to_param}, valid_session
      assigns(:argument_post).should eq(argument_post)
    end
  end

  describe "POST create" do
    before do 
      sign_in user, no_capybara: true
    end
    describe "with valid params" do
      it "creates a new ArgumentPost" do
        expect {
          post :create, {:argument_post => valid_attributes}, valid_session
        }.to change(ArgumentPost, :count).by(1)
      end

      it "assigns a newly created argument_post as @argument_post" do
        post :create, {:argument_post => valid_attributes}, valid_session
        assigns(:argument_post).should be_a(ArgumentPost)
        assigns(:argument_post).should be_persisted
      end

      it "redirects to the debate page of the argument_post" do
        post :create, {:argument_post => valid_attributes}, valid_session
        response.should redirect_to(debate_path(ArgumentPost.last.debate))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved argument_post as @argument_post" do
        # Trigger the behavior that occurs when invalid params are submitted
        ArgumentPost.any_instance.stub(:save).and_return(false)
        post :create, {:argument_post => { "content" => "invalid value" }}, valid_session
        assigns(:argument_post).should be_a_new(ArgumentPost)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        ArgumentPost.any_instance.stub(:save).and_return(false)
        post :create, {:argument_post => { "content" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested argument_post" do
        argument_post = ArgumentPost.create! valid_attributes
        # Assuming there are no other argument_posts in the database, this
        # specifies that the ArgumentPost created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        ArgumentPost.any_instance.should_receive(:update).with({ "content" => "MyText" })
        put :update, {:id => argument_post.to_param, :argument_post => { "content" => "MyText" }}, valid_session
      end

      it "assigns the requested argument_post as @argument_post" do
        argument_post = ArgumentPost.create! valid_attributes
        put :update, {:id => argument_post.to_param, :argument_post => valid_attributes}, valid_session
        assigns(:argument_post).should eq(argument_post)
      end

      it "redirects to the debate page of the updated argument_post" do
        argument_post = ArgumentPost.create! valid_attributes
        put :update, {:id => argument_post.to_param, :argument_post => valid_attributes}, valid_session
        response.should redirect_to(debate_url(argument_post.debate))
      end
    end

    describe "with invalid params" do
      it "assigns the argument_post as @argument_post" do
        argument_post = ArgumentPost.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        ArgumentPost.any_instance.stub(:save).and_return(false)
        put :update, {:id => argument_post.to_param, :argument_post => { "content" => "invalid value" }}, valid_session
        assigns(:argument_post).should eq(argument_post)
      end

      it "re-renders the 'edit' template" do
        argument_post = ArgumentPost.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        ArgumentPost.any_instance.stub(:save).and_return(false)
        put :update, {:id => argument_post.to_param, :argument_post => { "content" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested argument_post" do
      argument_post = ArgumentPost.create! valid_attributes
      expect {
        delete :destroy, {:id => argument_post.to_param}, valid_session
      }.to change(ArgumentPost, :count).by(-1)
    end

    it "redirects to the argument_posts list" do
      argument_post = ArgumentPost.create! valid_attributes
      delete :destroy, {:id => argument_post.to_param}, valid_session
      response.should redirect_to(argument_posts_url)
    end
  end

end
