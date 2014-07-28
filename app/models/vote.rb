class Vote < ActiveRecord::Base
  belongs_to :user
end

class DebateVote < Vote
  belongs_to :debate, foreign_key: "subject_id"
end

class ArgumentVote < Vote
  belongs_to :argument_post, foreign_key: "subject_id"
end