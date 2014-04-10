class ArgumentPost < ActiveRecord::Base
  belongs_to :user
  belongs_to :debate
  validates :user_id, :debate_id, :content, :type, presence: :true
  validates :type, inclusion: { in: %w(OriginalPost ContributionPost CorrectionPost CounterArgumentPost),
    message: "%{value} is not a valid size" }
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