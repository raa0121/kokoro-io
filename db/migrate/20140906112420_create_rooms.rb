class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :room_name
      t.string :screen_name
      t.boolean :private

      t.timestamps
    end
  end
end
