class RenameItemIdToListingIdInBids < ActiveRecord::Migration
  def change
    rename_column :bids, :item_id, :listing_id
  end
end
