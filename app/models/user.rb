class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :order
  
  easy_roles :roles

  structure do
    name       :string, :validates => :presence
    roles      :string
  end

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name

  def order
    super || self.create_order
  end

  def self.users_with_open_order
    User.includes(:order).where('orders.state = ?', "open")
  end

  def self.users_with_processing_order
    User.includes(:order).where('orders.state = ?', "processing")
  end

  def self.users_with_unpaid_processing_order
    User.includes(:order).where('orders.state = ? AND orders.paid = ?', "processing", false)
  end

  def self.users_with_paid_processing_order
    User.includes(:order).where('orders.state = ? AND orders.paid = ?', "processing", true)
  end

  def self.users_with_delivered_order
    User.includes(:order).where('orders.state = ?', "delivered")
  end
end
