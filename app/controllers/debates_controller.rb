class DebatesController < ApplicationController
  before_action :check_signed_in_user, only: [:new, :edit, :update, :create, :destroy]
  before_action :check_correct_user, only: [:edit, :update, :destroy] 
  before_action :set_debate, only: [:show, :edit, :update, :destroy, :delete]
  
  def index
    #@debates = Debate.paginate(page: params[:page])
    @debates = Debate.joins("LEFT JOIN votes ON votes.votable_id = debates.id and votes.votable_type = 'Debate'")
                .group("debates.id")
                .order("SUM(votes.value) ASC, debates.created_at DESC")
                .paginate(page: params[:page])
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
    @affirmative_posts = @debate.argument_posts
                            .where(position: "affirmative", type: ["OriginalPost", "CounterArgumentPost"])
                            .sort_by { |argument_post| -argument_post.score }

    @negative_posts = @debate.argument_posts
                          .where(position: "negative", type: ["OriginalPost", "CounterArgumentPost"])
                          .sort_by { |argument_post| -argument_post.score }
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
      redirect_incorrect_users_to_root(@debate.user_id)
    end
end