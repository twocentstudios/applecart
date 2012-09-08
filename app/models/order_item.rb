class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :item

  structure do
    quantity    :integer, :validates => :presence
  end

  attr_accessible :quantity

  def total
  	item.price * quantity
  end

  def total_cost
  	item.cost * quantity
  end
  
end

