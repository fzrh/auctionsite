class RenameItemsToListings < ActiveRecord::Migration
  def change
    rename_table :items, :listings
  end
end
