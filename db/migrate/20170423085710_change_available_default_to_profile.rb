class ChangeAvailableDefaultToProfile < ActiveRecord::Migration[5.0]
  def change
    change_column_default(:profiles, :available, true)
  end
end
