class Item < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :item_informations, dependent: :destroy
end
