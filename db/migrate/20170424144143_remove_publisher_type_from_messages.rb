class RemovePublisherTypeFromMessages < ActiveRecord::Migration[5.0]
  def change
    rename_column :messages, :publisher_id, :profile_id
    remove_column :messages, :publisher_type, :string
  end
end
