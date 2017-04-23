class RemoveScreenNameFromBots < ActiveRecord::Migration[5.0]
  def change
    remove_column :bots, :screen_name, :string
  end
end
