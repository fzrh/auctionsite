class ChangeFinalPriceDefaultValueInItems < ActiveRecord::Migration
  def change
    change_column :items, :final_price, :decimal, default: nil
  end
end
