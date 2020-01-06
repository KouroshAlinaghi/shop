class User < ApplicationRecord
  attr_accessor :remember_token
  has_secure_password

  has_many :comments, dependent: :destroy
  has_one :cart, dependent: :destroy

  validates :admin, :inclusion => { :in => [true, false] }
  validates :username, presence: true, uniqueness: true
  validates :email, uniqueness: true, presence: true

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end
end
