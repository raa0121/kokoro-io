class AddNotNullConstraintToBots < ActiveRecord::Migration
  def change
    [:user_id, :access_token, :bot_name, :screen_name, :status].each do |column|
      change_column_null :bots, column, false
    end
  end
end
