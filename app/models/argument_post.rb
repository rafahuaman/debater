class ArgumentPost < ActiveRecord::Base
  belongs_to :user
  belongs_to :debate
  has_many :children, class_name: "ArgumentPost", foreign_key: "parent_id"
  has_many :votes, class_name: "ArgumentVote", foreign_key: "subject_id"
  belongs_to :parent, class_name: "ArgumentPost"
  validates :user_id, :debate_id, :content, :type, :position, presence: :true
  validates :type, inclusion: { in: %w(OriginalPost ContributionPost CorrectionPost CounterArgumentPost),
    message: "%{value} is not a valid Type" }
  validates :position, inclusion: { in: %w(affirmative negative),
    message: "%{value} is not a valid Position" }
  validates :content, length: { maximum: 5000 }

  def self.types
    ["OriginalPost","ContributionPost","CorrectionPost","CounterArgumentPost"]
  end

  def agreeing_children
    self.children.where(position: self.position)
  end

  def disagreeing_children
    self.children.where(position: self.opposite_position)
  end

  def opposite_position
    if self.position == "affirmative" then
      "negative"
    else
      "affirmative"
    end
  end

  def has_counters?
    !self.disagreeing_children.empty?
  end

  def vote_type
    "ArgumentVote"
  end

end

class OriginalPost < ArgumentPost
  
end

class ContributionPost < ArgumentPost
end

class CorrectionPost < ArgumentPost
end

class CounterArgumentPost < ArgumentPost
end