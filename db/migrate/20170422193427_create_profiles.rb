class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.references :publisher, polymorphic: true
      t.string :display_name
      t.string :screen_name
      t.string :avatar_id
      t.boolean :available

      t.timestamps
    end
  end
end
