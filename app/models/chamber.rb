class Chamber < ActiveRecord::Base
  has_many :debates, dependent: :destroy
end
