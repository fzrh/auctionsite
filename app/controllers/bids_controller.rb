class BidsController < ApplicationController
  before_action :authenticate_user!

  def new
    @bid = Bid.new
  end

  def create
    @item = Item.find(params[:item_id])
    @bid = @item.bids.new(bid_params)
    @bid.user_id = current_user.id
    if @bid.save
      redirect_to item_path(@item)
    else
      render
    end
  end

  private
  def bid_params
    params.require(:bid).permit(:user_id, :item_id, :amount, :status)
  end
end
