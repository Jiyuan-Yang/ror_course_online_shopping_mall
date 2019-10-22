class Shop < ApplicationRecord
  validates :name, presence: true, length: {maximum: 30}
  validates :description, presence: true, length: {minimum: 10, maximum: 100}

  belongs_to :user
  has_many :products
end
