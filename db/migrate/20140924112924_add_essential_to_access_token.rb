class AddEssentialToAccessToken < ActiveRecord::Migration
  def change
    add_column :access_tokens, :essential, :boolean
  end
end
