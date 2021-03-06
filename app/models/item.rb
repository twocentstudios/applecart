class Item < ActiveRecord::Base
  has_many :order_items

  image_accessor :item_photo
  structure do
    name          "Snickers Apple", :validates => :presence
    description   "This apple has a lot of snickers candy all over it and tastes fantastic.", :validates => :presence
    price         :decimal, :validates => :numericality
    cost          :decimal, :validates => :numericality
    item_photo_uid     :string  #dragonfly not used
    photo_url     :string       #simple url store for hotlinking
  end

  attr_accessible :name, :description, :price, :cost, :photo_url

  def total
    total = 0
    order_items.map do |oi| 
      if oi.order.state != 'open'
        total += oi.quantity
      end
    end
    return total
  end
end

