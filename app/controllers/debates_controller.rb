class DebatesController < ApplicationController
  before_action :check_signed_in_user, only: [:create, :destroy]
  before_action :set_debate, only: [:show, :edit, :update, :destroy, :delete]
  
  def index
    @debates = Debate.all
  end
  
  def create
  end
  
  def destroy
  end
  
  def show
  end
  
  def edit
  end
  
  def update
  end
  
  def delete
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_debate
      @debate = Debate.find(params[:id])
    end
end