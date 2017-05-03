class RenameAvailableColumnToProfile < ActiveRecord::Migration[5.0]
  def change
    rename_column :profiles, :available, :archived
  end
end
