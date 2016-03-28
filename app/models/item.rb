class Item < ActiveRecord::Base
  belongs_to :user
  has_many :bids

  default_scope -> { order('items.created_at DESC') }
end
