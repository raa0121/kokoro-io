class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :screen_name
      t.string :user_name
      t.string :avatar_url

      t.timestamps
    end
  end
end
