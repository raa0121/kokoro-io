class ChangeArchivedDefaultToProfile < ActiveRecord::Migration[5.0]
  def change
    change_column_default(:profiles, :archived, false)
  end
end
