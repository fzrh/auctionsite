class BidsController < ApplicationController
  before_action :authenticate_user!

  def new
    @bid = Bid.new
  end

  def create
    @listing = Listing.find(params[:listing_id])
    @bid = @listing.bids.new(bid_params)
    @bid.user_id = current_user.id
    if @bid.save
      redirect_to listing_path(@listing), notice: 'Bid saved!'
    else
      redirect_to listing_path(@listing), error: 'Bid cannot be saved'
    end
  end

  private
  def bid_params
    params.require(:bid).permit(:user_id, :listing_id, :amount, :status)
  end
end
