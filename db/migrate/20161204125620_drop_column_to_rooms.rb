class DropColumnToRooms < ActiveRecord::Migration[5.0]
  def change
    remove_index :rooms, :slug
    remove_column :rooms, :slug
  end
end
