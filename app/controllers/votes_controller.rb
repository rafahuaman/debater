class VotesController < ApplicationController
  #before_action :signed_in_user

  def create
  
    current_user.vote!(params[:votable], params[:value])
    respond_to do |format|
      format.js
    end
  end

  def destroy
    #@user = Relationship.find(params[:id]).followed
    #current_user.unfollow!(@user)
    #redirect_to @user
  end
end