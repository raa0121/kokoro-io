class RemoveBotNameFromBots < ActiveRecord::Migration[5.0]
  def change
    remove_column :bots, :bot_name, :string
  end
end
