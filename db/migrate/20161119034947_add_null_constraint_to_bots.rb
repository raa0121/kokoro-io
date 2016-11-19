class AddNullConstraintToBots < ActiveRecord::Migration
  def change
    change_column_null :bots, :user_id, false
    change_column_null :bots, :bot_name, false
    change_column_null :bots, :screen_name, false
    change_column_null :bots, :access_token, false
    change_column_null :bots, :status, false
  end
end
