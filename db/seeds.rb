# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create Apples
@apples = []
@apples << {:name => "Apple Pie Apple", 
	:description => "Test", 
	:photo_url => "https://rockymountainchocolatefactory.com/rmcf/Documents/EComProductPictures/CA-105_-1249437839018640510_large.jpeg", 
	:price => 7, 
	:cost => 5}
@apples << {:name => "Caramel Apple", 
	:description => "Test", 
	:photo_url => "https://rockymountainchocolatefactory.com/rmcf/Documents/EComProductPictures/CA-101_-1025401869886859398_large.jpeg", 
	:price => 6, 
	:cost => 4}
@apples << {:name => "Caramel Apple with Snickers", 
	:description => "Test", 
	:photo_url => "https://rockymountainchocolatefactory.com/rmcf/Documents/EComProductPictures/CA-109_999292980267134713_large.jpeg", 
	:price => 8, 
	:cost => 6}

@apples.each do |apple_attr|
	Item.create(apple_attr)
end

# Create admin user
@admin = User.create(:name => "Admin User", 
	:password => "appleadmin",
	:email => "admin@example.com")
@admin.add_role('admin')
@admin.save!