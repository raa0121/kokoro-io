class CreateUserRooms < ActiveRecord::Migration
  def change
    create_table :user_rooms do |t|
      t.references :user, index: true
      t.references :room, index: true

      t.timestamps
    end
  end
end
