class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :listing

  default_scope -> { order('bids.created_at DESC') }

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validate :cannot_bid_on_self
  validate :check_if_highest_bid
  validate :check_listing_expiry_date
  validate :cannot_bid_multiple_times

  after_save :update_listing_final_price

  def cannot_bid_on_self
    if user.id == listing.user.id
      errors.add(:user, 'cannot bid on own listing')
    end
  end

  def check_if_highest_bid
    current_bid = self.listing.bids.first
    listing_price = self.listing.base_price
    if current_bid && current_bid.amount.to_i >= self.amount.to_i
      errors.add(:amount, 'must be higher than current bid')
    elsif current_bid == nil || listing_price.to_i >= self.amount.to_i
      errors.add(:amount, 'must be higher than set price')
    end
  end

  def check_listing_expiry_date
    errors.add(:amount, 'bidding has ended on this listing') if self.listing.end_date < Time.now
  end

  def update_listing_final_price
    self.listing.update_attribute(:final_price, self.amount)
  end

  def cannot_bid_multiple_times
    current_bid = self.listing.bids.first
    current_bidder = current_bid.user
    if current_bid && current_bidder.email == self.user.email
      errors.add(:amount, 'you cannot bid twice in a row')
    end
  end
end
