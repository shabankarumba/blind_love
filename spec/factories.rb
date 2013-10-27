require 'factory_girl'

FactoryGirl.define do
  factory :category do
    category_name "Trousers"
    slug "trousers"
  end

  factory :user do
    email "foo@bar.com"
    password "BarFarFaz"
    password_confirmation "BarFarFaz"
  end

  factory :department do
    department_name "mens"
    slug "mens"
  end

  factory :product do
  	sequence(:name)  {|n| "Foo#{n}" }
  	price 9999
  	description "I am a foobar"
    slug "foo"
    image Rails.root.join("spec/fixtures/images/boom.jpg").open
    department
    category
  end

  factory :category_department do
    category
    department
  end

  factory :size do
    size_name "Small"
  end

  factory :sizing do
    quantity 10
    size
    product
  end

  factory :basket do
    order
    status "Active"
  end

  factory :basket_item do
    product
    basket
    order
  end

  factory :order do
    title "Mr"
    first_name "Foo"
    last_name "Bar"
    address_1 "105 Arcadian Gardens"
    address_2 "London"
    number  4242424242424242
    cvc 234
    year 2020
    month 12
  end
end

