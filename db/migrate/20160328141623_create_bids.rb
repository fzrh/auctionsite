class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.references :user, index: true, foreign_key: true
      t.references :item, index: true, foreign_key: true
      t.decimal :amount
      t.integer :status, default: 1

      t.timestamps null: false
    end
  end
end
