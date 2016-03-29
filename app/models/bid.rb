class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :item

  default_scope -> { order('bids.created_at DESC') }

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validate :cannot_bid_on_self
  validate :check_if_highest_bid
  validate :check_listing_expiry_date

  after_save :update_item_final_price

  def cannot_bid_on_self
    if user.id == item.user.id
      errors.add(:user, 'cannot bid on own listing')
    end
  end

  def check_if_highest_bid
    current_bid = Bid.first
    errors.add(:amount, 'must be higher than current bid') unless current_bid.amount.to_i < self.amount.to_i
  end

  def check_listing_expiry_date
    errors.add(:amount, 'bidding has ended on this item') if self.item.end_date < Time.now
  end

  def update_item_final_price
    self.item.final_price = self.amount.to_i
    self.item.save
  end
end
