class ItemWithInformation
  include ActiveModel::Model
  attr_accessor :name, :unit, :category_id, :user_id, :deadline, :purchase_date, :quantity, :is_frozen

  with_options presence: true do
    validates :name, :category_id, :user_id, :quantity, :purchase_date
  end
  validates :name, length: { maximum: 20 }
  validates :quantity, numericality: { greater_than: 0, message: "is invalid" }, allow_blank: true
  validates :is_frozen, inclusion: { in: ["true", "false"] }

  def save
    return if invalid?

    ActiveRecord::Base.transaction do
      item = Item.find_or_create_by!(name: name, unit: unit, category_id: category_id, user_id: user_id)
      ItemInformation.create!(deadline: deadline, purchase_date: purchase_date, quantity: quantity, is_frozen: is_frozen, item_id: item.id, user_id: user_id)
    end
    return true
  rescue ActiveRecord::RecordInvalid
    return false
  end

  def update(info, item)
    return if invalid?

    ActiveRecord::Base.transaction do
      kari_item = Item.find_or_initialize_by(name: name, unit: unit, category_id: category_id, user_id: user_id)

      if kari_item.new_record?
        item.update!(name: name, unit: unit, category_id: category_id, user_id: user_id)
        info.update!(deadline: deadline, purchase_date: purchase_date, quantity: quantity, is_frozen: is_frozen, item_id: item.id, user_id: user_id)
      else
        info.update!(deadline: deadline, purchase_date: purchase_date, quantity: quantity, is_frozen: is_frozen, item_id: kari_item.id, user_id: user_id)

        unless item.item_informations.exists?
          item.destroy
        end
      end
    end
    return true
  rescue ActiveRecord::RecordInvalid
    return false
  end
end