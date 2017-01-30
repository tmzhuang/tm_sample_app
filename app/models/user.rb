class User < ApplicationRecord
  def self.email_regex
    user = "[\\w]+(([\\-.]?[\\w]+)*)"
    domain = "[a-z\\d]+(([\\-.]?[a-z\\d]+)*)\\.[a-z]+"
    result = /\A#{user}@#{domain}\z/i
  end

  before_save { email.downcase! }
  has_secure_password

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
    uniqueness: { case_sensitive: false },
    format: { with: email_regex }
  validates :password, presence: true, length: { minimum: 6 }

  class << self
    def digest(unencrypted_password)
      cost = ActiveModel::SecurePassword.min_cost ? 
        BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(unencrypted_password, cost: cost)
    end
  end
end
