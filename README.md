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
  - rank: float             // add later
  - **user_id**: integer
- Product
  - id: integer
  - name: string
  - description: text
  - price: float
  - picture_path: string    // add later
  - type: string    // add later
  - color: string    // add later
  - size: string (use size format like x\*y\*z)    // add later
  - **shop_id**: integer
- ShoppingCartItem
  - id: integer
  - **product_id**: integer
  - amount: integer
  - total_price: float    // add later or may be not useful
  - **shopping_cart_id**: integer \#\# test the ShoppingCart character case
- ShoppingCart
  - id: integer
  - **user_id**: integer
  - total_price: float    // add later or may be not useful
- FavoriteItem
  - id: integer    // this will be generate automatically
  - **product_id**: integer
  - **favorite_id**: integer 
- Favorite
  - id: integer    // this will be generate automatically
  - **user_id**: integer
- OrderItem
  - id: integer    // this will be generate automatically
  - **product_id**: integer
  - amount: integer
  - total_price: float    // add later
  - **order_id**: integer
- Order
  - id: integer    // this will be generate automatically
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