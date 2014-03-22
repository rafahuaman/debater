class User < ActiveRecord::Base
  has_many :debates, dependent: :destroy
  before_create :create_remember_token 
  validates :name, presence: true, uniqueness: true 
  validates :password, length: { minimum: 6 }
  has_secure_password
  
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end
  
  def User.hash(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  private
  
    def create_remember_token
      self.remember_token = User.hash(User.new_remember_token)
    end
end
