class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items

  structure do
    payed       false
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
end

