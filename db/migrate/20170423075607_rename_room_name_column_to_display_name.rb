class RenameRoomNameColumnToDisplayName < ActiveRecord::Migration[5.0]
  def change
    rename_column :rooms, :room_name, :display_name
  end
end
