class ItemWithInformation
  include ActiveModel::Model
  attr_accessor :name, :unit, :quantity_total, :category_id, :user_id, :deadline, :purchase_date, :quantity, :is_frozen, :item_id

  with_options presence: true do
    validates :name, :quantity_total, :category_id, :user, :item_id
  end
  validates :name, length: { maximum: 20 }
  with_options allow_blank: true do
    validates :quantity, numericality: { greater_than: 0 }
    validates :quantity_total, numericality: { greater_than_or_equal_to: 0 }
  end
  validates :is_frozen, inclusion: { in: [true, false] }

  private
  
  def self.singular_save(params)
    ActiveRecord::Base.transaction do
      if params[:item_id] == "0"
        item = Item.create!(name: params[:name], unit: params[:unit], quantity_total: params[:quantity_total], category_id: params[:category_id], user_id: params[:user_id])
        ItemInformation.create!(deadline: params[:deadline], purchase_date: params[:purchase_date], quantity: params[:quantity], user_id: params[:user_id], item_id: item.id)
      else
        item = Item.find(params[:item_id])
        item.update!(quantity_total: params[:quantity_total])
        ItemInformation.create!(deadline: params[:deadline], purchase_date: params[:purchase_date], quantity: params[:quantity], user_id: params[:user_id], item_id: params[:item_id])
      end
    end
      return true
    rescue => e
      return false
  end
end