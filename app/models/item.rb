class Item < ActiveRecord::Base
  belongs_to :user
  has_many :bids

  validates :title, presence: true, length: { minimum: 10, maximum: 140 }
  validates :base_price, presence: true, numericality: { only_integer: true }
  validates :expire_date, presence: true

  default_scope -> { order('items.created_at DESC') }
end
