require 'bcrypt'

class User < ApplicationRecord
  attr_reader :password

  before_validation :ensure_session_token
  validates :username, presence: true
  validates :session_token, presence: true
  validate :password_digest, :password_not_empty
  validates :password, length: {minimum: 6, allow_nil: true}
  
  
  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

  def password_not_empty
    if password_digest.empty?
      raise "Password can't be blank"
    end
  end



  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
end
