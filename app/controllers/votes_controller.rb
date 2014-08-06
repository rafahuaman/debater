class VotesController < ApplicationController
  before_action :check_signed_in_user

  def create
    votable_class = params[:vote][:votable_type].constantize
    votable = votable_class.find(params[:vote][:votable_id])
    current_user.vote!(votable, params[:vote][:value])
    respond_to do |format|
      format.html { redirect_to votable }
      format.js
    end
  end

  def destroy
    #@user = Relationship.find(params[:id]).followed
    #current_user.unfollow!(@user)
    #redirect_to @user
  end
end