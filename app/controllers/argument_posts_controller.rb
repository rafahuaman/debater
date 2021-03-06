class ArgumentPostsController < ApplicationController
  before_action :check_signed_in_user, only: [:new, :edit, :update, :create, :destroy]
  before_action :check_correct_user, only: [:edit, :update, :destroy] 
  before_action :set_argument_post, only: [:show, :edit, :update, :destroy]

  # GET /argument_posts
  # GET /argument_posts.json
  def index
    @argument_posts = ArgumentPost.all
  end

  # GET /argument_posts/1
  # GET /argument_posts/1.json
  def show
  end

  # GET /argument_posts/new
  def new
    @argument_post = ArgumentPost.new()
  end

  # GET /argument_posts/1/edit
  def edit
  end

  # POST /argument_posts
  # POST /argument_posts.json
  def create
    @argument_post = current_user.argument_posts.build(argument_post_params)

    respond_to do |format|
      if @argument_post.save
        format.html { redirect_to debate_url(@argument_post.debate), notice: 'Argument post was successfully created.' }
        format.json { render action: 'show', status: :created, location: @argument_post }
      else
        format.html { render action: 'new'  }
        format.json { render json: @argument_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /argument_posts/1
  # PATCH/PUT /argument_posts/1.json
  def update
    respond_to do |format|
      if @argument_post.update(argument_post_params)
        format.html { redirect_to debate_url(@argument_post.debate), notice: 'Argument post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @argument_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /argument_posts/1
  # DELETE /argument_posts/1.json
  def destroy
    @argument_post.destroy
    respond_to do |format|
      format.html { redirect_to argument_posts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_argument_post
      @argument_post = ArgumentPost.find(params[:id])
    end

    def type
      if  ArgumentPost.types.include?(params[:type])
        params[:type] 
      else
        "ArgumentPost"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def argument_post_params
      params.require(type.underscore.to_sym).permit(:content, :user_id, :debate_id, :type, :position, :parent_id)
      #params.require(:argument_post).permit(:content, :user_id, :debate_id, :type, :position, :parent_id)
    end

    def check_correct_user
      set_argument_post
      redirect_incorrect_users_to_root(@argument_post.user_id)
    end
end
