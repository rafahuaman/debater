class Debate < ActiveRecord::Base
  belongs_to :user
  belongs_to :chamber
  has_many :argument_posts
  has_many :votes, class_name: "DebateVote", foreign_key: "subject_id"
  default_scope -> { order('created_at DESC') }
  validates :user_id, :chamber_id ,:content, :title, :affirmative, :negative , presence: true
  validates :content, length: { maximum: 5000 }
  validates :title, :affirmative, :negative , length: { maximum: 300 }
end
