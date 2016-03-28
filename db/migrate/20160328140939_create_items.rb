class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.references :user, index: true, foreign_key: true
      t.string :title
      t.text :description
      t.string :default_image
      t.integer :duration
      t.decimal :base_price, default: 0.0
      t.integer :status, default: 1

      t.timestamps null: false
    end
  end
end
