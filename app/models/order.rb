class Order < ApplicationRecord
    belongs_to :user
    has_many :order_items, dependent: :delete_all
end
