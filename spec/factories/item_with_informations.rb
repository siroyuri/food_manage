FactoryBot.define do
  factory :item_with_information do
    name { "にんじん" }
    unit { "本" }
    quantity { 1 }
    deadline { Faker::Date.in_date_period }
    purchase_date { Faker::Date.in_date_period }
    is_frozen { "false" }
  end
end
