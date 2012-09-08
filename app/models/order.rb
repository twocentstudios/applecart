class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items

  structure do
    paid        false
    state       :string
  end

  include Stateflow

  stateflow do
    initial :open

    state :open, :processing, :delivered

    event :next_status do
      transitions :from => :open, :to => :processing
      transitions :from => :processing, :to => :delivered
    end
    
  end

  accepts_nested_attributes_for :order_items
  attr_accessible :order_items_attributes
  #attr_accessible :paid, :state

  def total
    total = 0
    order_items.map{ |oi| total += oi.total}
    return total
  end

  def total_cost
    total_cost = 0
    order_items.map{ |oi| total_cost += oi.total_cost }
    return total_cost
  end
end

