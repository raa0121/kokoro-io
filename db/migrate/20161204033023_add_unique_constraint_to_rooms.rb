class AddUniqueConstraintToRooms < ActiveRecord::Migration[5.0]
  def change
    add_index :rooms, :screen_name, unique: true
  end
end
