class RemoveQuantityTotalFromItems < ActiveRecord::Migration[6.0]
  def change
    remove_column :items, :quantity_total, :float
  end
end
