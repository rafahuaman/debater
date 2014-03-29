class Debate < ActiveRecord::Base
  belongs_to :user
  belongs_to :chamber
  default_scope -> { order('created_at DESC') }
  validates :user_id, :content, :title, :affirmative, :negative , presence: true
  validates :content, length: { maximum: 5000 }
  validates :title, :affirmative, :negative , length: { maximum: 300 }
end
