class DebatesController < ApplicationController
  before_action :check_signed_in_user, only: [:new, :edit, :update, :create, :destroy]
  before_action :check_correct_user, only: [:edit, :update, :destroy] 
  before_action :set_debate, only: [:show, :edit, :update, :destroy, :delete]
  
  def index
    @debates = Debate.all
  end
  
  def new
    @debate = Debate.new
  end
  
  def create
    @debate = current_user.debates.build(debate_params)
    if @debate.save
      redirect_to debate_path(@debate), notice: 'Debate was successfully created.' 
    else
      render action: 'new'
    end
    
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
  
     # Never trust parameters from the scary internet, only allow the white list through.
    def debate_params
      params.require(:debate).permit(:title, :content, :affirmative, :negative, :chamber_id)
    end
  
    def check_correct_user
      set_debate
      correct_user = User.find_by(id: @debate.user_id)
      redirect_to root_url unless current_user?(correct_user)
    end
end