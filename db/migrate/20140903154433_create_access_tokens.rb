class CreateAccessTokens < ActiveRecord::Migration
  def change
    create_table :access_tokens do |t|
      t.references :user, index: true
      t.string :name
      t.string :token

      t.timestamps
    end
  end
end
