class Chamber < ActiveRecord::Base
  belongs_to :user
  has_many :debates, dependent: :destroy
  validates :name, :description, :user, presence: true
  validates :name, uniqueness: true
end
