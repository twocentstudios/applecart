class Item < ActiveRecord::Base
  has_many :order_items

  image_accessor :item_photo
  structure do
    name          "Snickers Apple", :validates => :presence
    description   "This apple has a lot of snickers candy all over it and tastes fantastic.", :validates => :presence
    price         :decimal, :validates => :numericality
    cost          :decimal, :validates => :numericality
    item_photo_uid     :string
  end

  attr_accessible :name, :description, :price
end

