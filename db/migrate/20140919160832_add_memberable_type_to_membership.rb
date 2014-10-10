class AddMemberableTypeToMembership < ActiveRecord::Migration
  def change
    add_column :memberships, :memberable_type, :string
    add_index :memberships, [:memberable_id, :memberable_type]
  end
end
