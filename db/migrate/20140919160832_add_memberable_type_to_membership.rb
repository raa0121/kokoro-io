class AddMemberableTypeToMembership < ActiveRecord::Migration
  def change
    add_column :memberships, :memberable_type, :string
  end
end
