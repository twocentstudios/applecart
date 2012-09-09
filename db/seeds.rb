# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create Apples
@apples = []
@apples << {:name => "Snickers",
	:description => "The Snickers Apple has a crunchy Snickers exterior that will blow your mind!", 
	:photo_url => "https://rockymountainchocolatefactory.com/rmcf/Documents/EComProductPictures/CA-109_999292980267134713_large.jpeg", 
	:price => 8, 
	:cost => 3.5}
@apples << {:name => "Apple Pie", 
	:description => "There's no fork needed to eat this apple pie, but it's just as tasty!", 
	:photo_url => "https://rockymountainchocolatefactory.com/rmcf/Documents/EComProductPictures/CA-105_-1249437839018640510_large.jpeg", 
	:price => 8, 
	:cost => 3.5}
@apples << {:name => "Chocolate Chip", 
	:description => "The Chocolate Chip Apple has a caramel coating smothered in little bundles of chocolately chip goodness!", 
	:photo_url => "", 
	:price => 8, 
	:cost => 3.5}
@apples << {:name => "Caramel", 
	:description => "The Classic Candy Apple is chewy caramel coated and is a classic for a reason!", 
	:photo_url => "https://rockymountainchocolatefactory.com/rmcf/Documents/EComProductPictures/CA-101_-1025401869886859398_large.jpeg", 
	:price => 7, 
	:cost => 3.5}
@apples << {:name => "Peanut", 
	:description => "Better than the kind you buy in the store, this is the classic caramel apple covered in roasted peanuts!", 
	:photo_url => "https://rockymountainchocolatefactory.com/rmcf/Documents/EComProductPictures/CA-102_-1018912788775410226_large.jpeg", 
	:price => 7, 
	:cost => 3.5}
@apples << {:name => "Pecan", 
	:description => "Don't like peanuts? Try a caramel apple covered in roasted pecan bits!", 
	:photo_url => "https://rockymountainchocolatefactory.com/rmcf/Documents/EComProductPictures/CA-103_4411037393180743059_large.jpeg", 
	:price => 7, 
	:cost => 3.5}
@apples << {:name => "Toffee", 
	:description => "Chewy caramel apple covered in pieces of toffee!",
	:photo_url => "https://rockymountainchocolatefactory.com/rmcf/Documents/EComProductPictures/CA-110_-2872963933654827673_large.jpeg", 
	:price => 7, 
	:cost => 3.5}

@apples.each do |apple_attr|
	Item.create(apple_attr)
end

# Create admin user
@admin = User.create(:name => "Admin User", 
	:password => "appleadmin",
	:email => "admin@example.com")
@admin.add_role('admin')
@admin.save!