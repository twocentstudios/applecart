FactoryGirl.define do

  factory :order_item do
  	order
    item
    quantity 0
  end

end
