class CreateBots < ActiveRecord::Migration
  def change
    create_table :bots do |t|
      t.references :user, index: true
      t.string :access_token
      t.string :bot_name
      t.string :screen_name
      t.integer :status

      t.timestamps
    end
  end
end
