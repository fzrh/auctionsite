class RenameBasePriceToSetPriceInListings < ActiveRecord::Migration
  def change
    rename_column :listings, :base_price, :set_price
  end
end
