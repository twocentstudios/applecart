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

    event :next_state do
      transitions :from => :open, :to => :processing
      transitions :from => :processing, :to => :delivered
      transitions :from => :delivered, :to => :open
    end

    event :reset do
      transitions :from => [:open, :processing, :delivered], :to => :open
    end
    
  end

  accepts_nested_attributes_for :order_items
  attr_accessible :order_items_attributes

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

  def total_apples
    total_apples = 0
    order_items.map{ |oi| total_apples += oi.quantity }
    return total_apples
  end

  def self.total
    total = 0
    Order.all.map { |o| total += o.total }
    return total
  end
end

