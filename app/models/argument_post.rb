class ArgumentPost < ActiveRecord::Base
  belongs_to :user
  belongs_to :debate
  has_many :children, class_name: "ArgumentPost", foreign_key: "parent_id"
  belongs_to :parent, class_name: "ArgumentPost"
  validates :user_id, :debate_id, :content, :type, :position, presence: :true
  validates :type, inclusion: { in: %w(OriginalPost ContributionPost CorrectionPost CounterArgumentPost),
    message: "%{value} is not a valid Type" }
  validates :position, inclusion: { in: %w(affirmative negative),
    message: "%{value} is not a valid Position" }
  validates :content, length: { maximum: 5000 }
end

class OriginalPost < ArgumentPost
  
end

class ContributionPost < ArgumentPost
end

class CorrectionPost < ArgumentPost
end

class CounterArgumentPost < ArgumentPost
end