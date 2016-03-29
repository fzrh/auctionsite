class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :item

  default_scope -> { order('bids.created_at DESC') }

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validate :cannot_bid_on_self

  after_save :update_item_final_price

  def cannot_bid_on_self
    if user.id == item.user.id
      errors.add(:user, 'cannot bid on own listing')
    end
  end

  def update_item_final_price
    self.item.final_price = self.amount.to_i
    self.item.save
  end
end
