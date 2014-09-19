class RemoveUserIdFromMembership < ActiveRecord::Migration
  def change
    remove_reference :memberships, :user, index: true
  end
end
