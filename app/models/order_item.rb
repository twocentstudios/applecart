class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :item

  structure do
    quantity    :integer, :validates => :presence
  end
end

