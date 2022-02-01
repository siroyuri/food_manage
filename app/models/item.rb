class Item < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :item_informations
  
  with_options presence: true do
    validates :name
    validates :quantity_total
  end
end
