class RenameUnitIdColumnToItems < ActiveRecord::Migration[6.0]
  def change
    rename_column :items, :unit_id, :unit
  end
end
