class AddMemberableIdToMembership < ActiveRecord::Migration
  def change
    add_reference :memberships, :memberable, index: true
  end
end
