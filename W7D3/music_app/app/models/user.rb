class User < ApplicationRecord
  validates :session_token, presence: true
  after_initialize :ensure_session_token
  attr_reader :password


  def self.find_by_credentials(email, password)
    user = User.find_by(email: email) #MAY NEED TO CHANGE
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16) #Creates a new session token
  end
  def reset_session_token!
    self.session_token = self.generate_session_token
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password) 
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end


end