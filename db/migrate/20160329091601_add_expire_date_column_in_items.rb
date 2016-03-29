class AddExpireDateColumnInItems < ActiveRecord::Migration
  def change
    add_column :items, :expire_date, :datetime unless column_exists? :items, :expire_date
    remove_column :items, :duration if column_exists? :items, :duration
  end
end
