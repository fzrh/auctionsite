class Listing < ActiveRecord::Base
  belongs_to :user
  has_many :bids, dependent: :destroy

  validates :title, presence: true, length: { maximum: 140 }
  validates :base_price, presence: true, numericality: { only_integer: true }
  validates :end_date, presence: true

  default_scope -> { order('listings.created_at DESC') }
  scope :current, -> { where('end_date >= ?', Time.now) }
  scope :ended, -> { where('end_date <= ?', Time.now) }
end
