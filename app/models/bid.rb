class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :item

  default_scope -> { order('bids.created_at DESC') }
end
