class RenameColumnInItems < ActiveRecord::Migration
  def change
    rename_column :items, :expire_date, :end_date
  end
end
