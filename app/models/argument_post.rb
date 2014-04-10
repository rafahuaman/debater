class ArgumentPost < ActiveRecord::Base
  belongs_to :user
  belongs_to :debate
end

class OriginalPost < ArgumentPost
  
end

class ContributionPost < ArgumentPost
end

class CorrectionPost < ArgumentPost
end

class CounterArgumentPost < ArgumentPost
end