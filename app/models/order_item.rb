class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :item

  structure do
    quantity    :integer, :validates => :presence
  end

  def total
  	item.price * quantity
  end
  
end

