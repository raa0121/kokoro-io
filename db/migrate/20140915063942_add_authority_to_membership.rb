class AddAuthorityToMembership < ActiveRecord::Migration
  def change
    add_column :memberships, :authority, :integer
  end
end
