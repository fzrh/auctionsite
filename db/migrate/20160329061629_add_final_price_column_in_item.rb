class AddFinalPriceColumnInItem < ActiveRecord::Migration
  def change
    add_column :items, :final_price, :decimal, default: 0.00 unless column_exists? :items, :final_price
  end
end
