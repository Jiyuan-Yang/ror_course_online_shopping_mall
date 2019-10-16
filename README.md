# RoR Web Project in Course 2019

## Structure

- User
  - id: integer
  - name: string
  - email: string
  - character: string (domin: buyer, seller, administrator)
  - password (use the function from rails, add it later, as well as confirmation)
- Product
  - id: integer
  - name: string
  - description: text
  - price: float
  - picture_path: string
  - type: string
  - color: string
  - size: string (use size format like x\*y\*z) 
  - shop_id: integer
- Shop
  - id: integer
  - name: string
  - description: text
  - rank: float 
  - user_id: integer
- ShoppingCart
  - id: integer
  - user_id: integer
- Order
  - id: integer
  - receiver_name: string
  - receiver_address: string
  - receiver_phone_number: string
  - status: string
  - order_time: date
  - total_price: float
- OrderItem
  - id: integer
  - product_id: integer
  - amount: integer
  - order_id: integer

## Tips

- We use Ruby 2.5.1 and rails 5.2.x, check it first.
- Execute `bundle install` and failed, remove the `Gemfile.lock` file and try again.