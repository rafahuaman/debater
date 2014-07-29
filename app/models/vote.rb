class Vote < ActiveRecord::Base
  belongs_to :user
  validates :user, :subject_id, :value, :type, presence: true
  validates :subject_id, uniqueness: { scope: [:user, :type], message: "You can only vote once per debate or comment" }
  validates :value, inclusion: { in: [-1, 1] }
  validates :type, inclusion: { in: %w(DebateVote ArgumentVote),  message: "%{value} is not a valid Type" }
end

class DebateVote < Vote
  belongs_to :debate, foreign_key: "subject_id"
end

class ArgumentVote < Vote
  belongs_to :argument_post, foreign_key: "subject_id"
end