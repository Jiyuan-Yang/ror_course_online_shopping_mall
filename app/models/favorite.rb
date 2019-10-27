class Favorite < ApplicationRecord
    belongs_to :user
    has_many :favorite_items
end
