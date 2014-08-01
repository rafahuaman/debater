class User < ActiveRecord::Base
  has_many :debates, dependent: :destroy
  has_many :chambers
  has_many :argument_posts
  has_many :votes
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

  def vote!(votable, vote_value)
    vote = self.votes.create(votable_type: votable.vote_type, 
                      votable_id: votable.id, value: vote_value)
  end

  def unvote!(votable)
    self.votes.find_by(votable_type: votable.vote_type, votable_id: votable.id).destroy
  end
  
  private
  
    def create_remember_token
      self.remember_token = User.hash(User.new_remember_token)
    end
end
