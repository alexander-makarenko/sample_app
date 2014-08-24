class User < ActiveRecord::Base

  before_save   { email.downcase! }
  before_create :create_remember_token

  VALID_EMAIL_REGEX = /\A[\w+-]+(\.[\w-]+)*@[a-z\d]+(\.[a-z\d-]+)*(\.[a-z]{2,4})\z/i
  
  validates :name,     presence: true, length: { maximum: 50 }
  validates :email,    presence: true, format: { with: VALID_EMAIL_REGEX },
                       uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }

  has_secure_password

  class << self
    def new_remember_token
      SecureRandom.urlsafe_base64
    end

    def digest(token)
      Digest::SHA1.hexdigest(token.to_s)
    end
  end

  private
  
    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end
end