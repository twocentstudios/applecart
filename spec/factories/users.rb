# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	sequence :name do |n|
		"John#{n} Doe"
	end
	
	sequence :email do |n|
		"user#{n}@example.com"
	end

  factory :user do
  	name
  	email
  	password 'password'
  end

  factory :admin, class: User do
  	name 'John Admin'
  	email 'admin@example.com'
  	password 'password'

  	after(:create) do |user, evaluator|
  		user.add_role! 'admin'
  	end
  end
end
