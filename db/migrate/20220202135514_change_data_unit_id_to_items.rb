class ChangeDataUnitIdToItems < ActiveRecord::Migration[6.0]
  def change
    change_column :items, :unit_id, :string
  end
end
