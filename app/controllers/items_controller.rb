class ItemsController < ApplicationController
  def show
    @item = Item.find(params[:id])
    @bid = Bid.new
    @item_bids = @item.bids
  end
end
