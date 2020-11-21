class User < ApplicationRecord

  before_save { self.email = email.downcase }
  validates :login, presence: true
  validates :fullname, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
  format: { with: VALID_EMAIL_REGEX },
  uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, length: { minimum: 6 }

  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :country, presence: true
  validates :zip, presence: true
  validates :role, presence: true

end
