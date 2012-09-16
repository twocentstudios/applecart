# Jen's Apples

## Models
* User
	* has_one :order
	* string :email
	* string :name
	* role :admin
* Item
	* has_many :order_items
	* string :name
	* text :description
	* string :photo
	* decimal :price
	* decimal :cost
* Order
	* belongs_to :user
	* has_many :order_items
	* stateflow :state => "open", "processing", "delivered"
	* bool :paid, :default => :false
* OrderItem
	* belongs_to :order
	* belongs_to :item
	* int :quantity
	
## Routes
* /apples
* /apple/1
* /order/1
* /user/1 ~> /order/1

## in SASS file
$bootstrap_var: #322;
@import 'bootstrap'; or 'bootstrap-responsive'

## Decisions
* orders don't count against totals normally unless they've been submitted (state == processing or state == delivered)
* orders aren't shown or counted if they are completely empty (apples == 0)
* item totals don't count items added to open orders