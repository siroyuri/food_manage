FactoryBot.define do
  factory :category do
    name { "" }
    category_list_id { "1" }
    association :user
  end
end
