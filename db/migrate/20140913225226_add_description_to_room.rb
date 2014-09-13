class AddDescriptionToRoom < ActiveRecord::Migration
  def change
    add_column :rooms, :description, :text
  end
end
