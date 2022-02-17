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
      item = Item.where(name: name, unit: unit, category_id: category_id, user_id: user_id).first_or_create
      ItemInformation.create(deadline: deadline, purchase_date: purchase_date, quantity: quantity, is_frozen: is_frozen, item_id: item.id, user_id: user_id)
    end
  rescue ActiveRecord::RecordInvalid
    false
  end

  def update(info, item)
    return if invalid?

    ActiveRecord::Base.transaction do
      if Item.where(name: name, unit: unit, category_id: category_id, user_id: user_id).exists?
        item_exist = Item.where(name: name, unit: unit, category_id: category_id, user_id: user_id)
        info.update(deadline: deadline, purchase_date: purchase_date, quantity: quantity, is_frozen: is_frozen, item_id: item_exist.ids.join, user_id: user_id)
        item.destroy
      else
        item.update(name: name, unit: unit, category_id: category_id, user_id: user_id)
        info.update(deadline: deadline, purchase_date: purchase_date, quantity: quantity, is_frozen: is_frozen, item_id: item.id, user_id: user_id)
      end
    end
  rescue ActiveRecord::RecordInvalid
    false
  end
end