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
    Order.where("state != ?", 'open').map { |o| total += o.total }
    return total
  end

  def self.total_cost
    total_cost = 0
    Order.where("state != ?", 'open').map{ |o| total_cost += o.total_cost }
    return total_cost
  end

  def self.money_owed
    money_owed = 0
    Order.where("paid = ? AND state != ?", false, 'open').map{ |o| money_owed += o.total }
    return money_owed
  end

  def self.money_received
    money_owed = 0
    Order.where("paid = ? AND state != ?", true, 'open').map{ |o| money_owed += o.total }
    return money_owed
  end

  def self.profit
    return self.total - self.total_cost
  end

  def self.non_empty(orders)
    non_empty_orders = []
    orders.map do |e| 
      if e.total_apples > 0
        non_empty_orders << e
      end
    end
    return non_empty_orders
  end

  def self.all_non_empty
    self.non_empty(Order.includes(:user).order("users.name ASC"))
  end

  def self.open
    self.non_empty(Order.where('state = ?', 'open'))
  end

  def self.processing
    self.non_empty(Order.where('state = ?', 'processing'))
  end

  def self.delivered
    self.non_empty(Order.where('state = ?', 'delivered'))
  end
end

