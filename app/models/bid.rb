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

  # def check_if_highest_bid
  #   current_bid = self.item.bids.first
  #   if self.item.base_price && current_bid.nil?
  #     errors.add(:amount, 'must be higher than current bid') unless self.item.base_price.to_i < self.amount.to_i
  #   elsif current_bid
  #     errors.add(:amount, 'must be higher than current bid') unless current_bid.amount.to_i < self.amount.to_i
  #   end
  # end

  # def check_if_highest_bid
  #   current_bid = self.item.bids.first
  #   return true unless current_bid.nil?
  #   errors.add(:amount, 'must be higher than current bid') unless current_bid.amount.to_i < self.amount.to_i
  # end

  def check_if_highest_bid #puaka khaliq jaga
    current_bid = self.item.bids.first
    item_price = self.item.base_price
    if current_bid && current_bid.amount.to_i > self.amount.to_i
      errors.add(:amount, 'must be higher than current bid')
    elsif current_bid == nil || item_price.to_i >= self.amount.to_i
      errors.add(:amount, 'must be higher than set price')
    end
  end

  def check_listing_expiry_date
    errors.add(:amount, 'bidding has ended on this item') if self.item.end_date < Time.now
  end

  def update_item_final_price
    self.item.update_attribute(:final_price, self.amount)
  end
end
