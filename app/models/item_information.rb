class ItemInformation < ApplicationRecord
  belongs_to :item

  validates :is_frozen, inclusion: { in: [true, false] }
end
