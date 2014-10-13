class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :user, index: true
      t.string :title
      t.text :message
      t.boolean :read, default: false
      t.string :redirect_url
      t.string :image_url

      t.timestamps
    end
  end
end
