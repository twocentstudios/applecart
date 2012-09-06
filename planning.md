# Jen's Apples

## Models
* User
	* has_one :order
	* string :email
	* string :name
	* bool :admin
* Item
	* has_many :order_items
	* string :name
	* text :description
	* string :photo
	* decimal :price
	* decimal :cost
* Order
	* belongs_to :customer
	* has_many :order_items
	* enum :status => "open", "processing", "delivered"
	* bool :payed, :default => :false
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