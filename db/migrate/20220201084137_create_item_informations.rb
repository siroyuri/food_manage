class CreateItemInformations < ActiveRecord::Migration[6.0]
  def change
    create_table :item_informations do |t|
      t.date :deadline
      t.date :purchase_date
      t.float :quantity
      t.boolean :is_frozen, null: false, default: false
      t.references :user,   null: false, foreign_key: true
      t.references :item,   null: false, foreign_key: true
      t.timestamps
    end
  end
end
