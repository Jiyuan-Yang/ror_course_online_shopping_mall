class User < ApplicationRecord
  before_save { self.email = email.downcase }

  validates :name, presence: true, length: {maximum: 50}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}

  CHARACTERS = %w(buyer seller administrator)
  validates_inclusion_of :character, :in => CHARACTERS

  has_secure_password
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true

  VALID_RECEIVER_NAME_REGEX = /\A[a-z]*\z/i
  validates :receiver_name, format: {with: VALID_RECEIVER_NAME_REGEX, message: 'Your name must be character between a-z'}
  VALID_RECEIVER_PHONE_REGEX = /\A\d{11}\z/
  validates :receiver_phone_number, format: {with: VALID_RECEIVER_PHONE_REGEX, message: 'The phone number should contain 11 numbers'}

  has_many :shops
  has_one :shopping_cart
  has_one :favorite
  has_many :orders
end
