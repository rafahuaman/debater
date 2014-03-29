class UsersController < ApplicationController
  before_action :check_signed_in_user, only: [:edit, :update, :destroy]
  before_action :check_correct_user, only: [:edit, :update, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy, :delete]
  

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @debates = @user.debates
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html do
          sign_in @user
          redirect_to root_path, notice: 'User was successfully created.' 
        end
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if @user.authenticate(params[:user][:password])
      @user.destroy
      respond_to do |format|
        format.html { redirect_to root_url, notice: "User was succesfully deleted." }
        format.json { head :no_content }
      end
    else
      render 'delete', alert: "Invalid password"
    end
  end
  
  def delete
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation)
    end
  
#    def check_signed_in_user
 #     store_location
  #    redirect_to signin_url, alert: "Please sign in." unless signed_in?
   # end
  
    def check_correct_user
      @user = User.find(params[:id])
      redirect_to root_url unless current_user?(@user)
    end
  
  
end
