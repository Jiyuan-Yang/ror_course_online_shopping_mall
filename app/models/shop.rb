class Shop < ApplicationRecord
  validates :name, presence: true, length: {maximum: 30},
            uniqueness: {case_sensitive: true}
  validates :description, presence: true, length: {minimum: 10, maximum: 100}

  belongs_to :user
  has_many :products, dependent: :delete_all
end
