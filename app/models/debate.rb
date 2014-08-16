class Debate < ActiveRecord::Base
  belongs_to :user
  belongs_to :chamber
  has_many :argument_posts
  has_many :votes, as: :votable
  default_scope -> { order('debates.created_at DESC') }
  # default_scope  joins("LEFT JOIN votes ON votes.votable_id = debates.id and votes.votable_type = 'Debate'")
  #               .group("debates.id")
  #               .order("SUM(votes.value) ASC, debates.created_at DESC")
  validates :user_id, :chamber_id ,:content, :title, :affirmative, :negative , presence: true
  validates :content, length: { maximum: 5000 }
  validates :title, :affirmative, :negative , length: { maximum: 300 }

  def vote_type
    "Debate"
  end

  def score
    self.votes.sum(:value)
  end
end