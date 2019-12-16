# RoR Web Project in Database Course 2019

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

## 第二阶段目标

初期基本已经完成，实现了实体及之间的基本关系的搭建。第二阶段预计使用一周半的时间完成。

- 前期只有增加和查找操作，要增加更改和删除。
- 对应地增加管理员用户的视图。
- 增加各种完整性约束，主要是程序层面的，如果可以，增加数据库层面的。
- 完善界面，这个要首先让页面内容人性化起来（比如要让购买者看到商品），先确保界面的结构，然后再让其美观，参考bootstrap的doc。
- 增加报表功能。

## 接下来的具体任务
- 完善一些细节功能，比如类似于AJAX，异步刷新
- 实现更严格的存取控制，防止直接路由的情况
- 完善页面结构设计，这里需要更具体讨论，现在先准备出一个结构，然后需要什么再加入什么
    - 主页：主页整体是上半部分为推荐商品，下半部分为商店及其热门商品。
        - 要对产品增加销量和类别的属性列，便于在主页中根据类别进行索引，同时能够排序
        - 主页正中央使用jQuery实现图片轮播
    - 商品展示页：除了显示商品的信息之外，还要根据类别标签显示相关商品。
    - 注册类页面：嵌入选项(radio)以及下拉菜单
- 实现报表功能
  

## Tips

- We use Ruby 2.5.1 and rails 5.2.x, check it first.
- Execute `bundle install` and failed, remove the `Gemfile.lock` file and try again.