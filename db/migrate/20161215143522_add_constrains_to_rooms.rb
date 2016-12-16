class AddConstrainsToRooms < ActiveRecord::Migration[5.0]
  def change
    change_column :rooms, :room_name, :string, :limit => 64, :null => false
    change_column :rooms, :screen_name, :string, :limit => 255, :null => false
    change_column :rooms, :private, :boolean, :default => false, :null => false
    change_column :rooms, :description, :text, :limit => 1000, :null => false
    add_index :rooms, :room_name, :unique => true
  end
end
