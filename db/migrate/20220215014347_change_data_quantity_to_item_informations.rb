class ChangeDataQuantityToItemInformations < ActiveRecord::Migration[6.0]
  def change
    change_column_null :item_informations, :quantity, false, 0
    change_column :item_informations, :quantity, :float, default: 0
    change_column_null :item_informations, :purchase_date, false
  end
end
