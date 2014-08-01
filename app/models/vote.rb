class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :votable, polymorphic: true
  validates :user, :votable_id, :value, :votable_type, presence: true
  validates :votable_id, uniqueness: { scope: [:user, :votable_type], message: "You can only vote once per debate or comment" }
  validates :value, inclusion: { in: [-1, 1] }
  validates :votable_type, inclusion: { in: %w(Debate ArgumentPost),  message: "%{value} is not a valid Type" }
end