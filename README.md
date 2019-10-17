# RoR Web Project in Course 2019

## Structure

### Model

- User
  - id: integer
  - name: string
  - email: string
  - character: string (domin: buyer, seller, administrator)
  - password (use the function from rails, add it later, as well as confirmation)
- Shop
  - id: integer
  - name: string
  - description: text
  - rank: float 
  - **user_id**: integer
- Product
  - id: integer
  - name: string
  - description: text
  - price: float
  - picture_path: string
  - type: string
  - color: string
  - size: string (use size format like x\*y\*z) 
  - **shop_id**: integer
- ShoppingCartItem
  - id: integer
  - **product_id**: integer
  - amount: integer
  - total_price: float
  - **shopping_cart_id**: integer \#\# test the ShoppingCart character case
- ShoppingCart
  - id: integer
  - **user_id**: integer
  - total_price: float
- FavoriteItem
  - id: integer
  - **product_id**: integer
  - **favorite_id**: integer \#\# test the ShoppingCart character case
- Favorite
  - id: integer
  - **user_id**: integer
- OrderItem
  - id: integer
  - **product_id**: integer
  - amount: integer
  - total_price: float
  - **buyer_order_id**: integer \#\# test the ShoppingCart character case
  - **seller_order_id**: integer \#\# test the ShoppingCart character case
- BuyerOrder
  - id: integer
  - receiver_name: string
  - receiver_address: string
  - receiver_phone_number: string
  - status: string
  - order_time: date
  - total_price: float
  - **user_id**: integer
- SellerOrder
  - id: integer
  - receiver_name: string
  - receiver_address: string
  - receiver_phone_number: string
  - status: string
  - order_time: date
  - total_price: float
  - **user_id**: integer

### Controller

- StaticPages
  - home
  - about
  - contact

## Tips

- We use Ruby 2.5.1 and rails 5.2.x, check it first.
- Execute `bundle install` and failed, remove the `Gemfile.lock` file and try again.