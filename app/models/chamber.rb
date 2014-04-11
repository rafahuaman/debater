class Chamber < ActiveRecord::Base
  has_many :debates, dependent: :destroy
  validates :name, :description, presence: true
  validates :name, uniqueness: true
end
