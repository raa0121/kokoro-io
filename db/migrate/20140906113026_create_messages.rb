class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :room, index: true
      t.references :publisher, index: true, polymorphic: true
      t.text :content
      t.datetime :published_at

      t.timestamps
    end
  end
end
