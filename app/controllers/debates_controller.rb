class DebatesController < ApplicationController
  before_action :check_signed_in_user, only: [:create, :destroy]
  
  def index
    @debates = Debate.all
  end
  
  def create
  end
  
  def destroy
  end
  
  def show
  end
end