class ItemInformation < ApplicationRecord
  belongs_to :item
  belongs_to :user

  validates :is_frozen, inclusion: { in: [true, false] }
end
