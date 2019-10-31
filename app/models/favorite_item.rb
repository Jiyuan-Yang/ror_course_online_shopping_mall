class FavoriteItem < ApplicationRecord
    validate :local_unique_validation

    belongs_to :favorite
    belongs_to :product

    private

    def local_unique_validation
        @fav = Favorite.find(favorite_id)
        judge = 0
        @fav.favorite_items.each do |item|
            if item.product_id == product_id and item.id != id
                judge = 1
            end
        end
        if judge == 1
            errors[:product_id] << 'It is already in your favorite'
        end
    end
end
