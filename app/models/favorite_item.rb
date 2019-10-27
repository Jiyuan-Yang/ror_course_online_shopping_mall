class FavoriteItem < ApplicationRecord
    belongs_to :favorite
    belongs_to :product
end
