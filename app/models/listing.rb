class Listing < ActiveRecord::Base
  belongs_to :user
  has_many :bids, dependent: :destroy

  enum status: { active: 1, expired: 2 }

  default_scope -> { order('listings.created_at DESC') }
  scope :current, -> { where('end_date >= ?', Time.now) }
  scope :ended, -> { where('end_date <= ?', Time.now) }

  validates :title, presence: true, length: { maximum: 140 }
  validates :set_price, presence: true, numericality: { only_integer: true }
  validates :end_date, presence: true
end
