class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update]

  def new
    @item = Item.new
  end

  def create
    @item = current_user.items.new(item_params)
    if @item.save
      redirect_to @item
    else
      render 'new'
    end
  end

  def show
    @bid = Bid.new
    @item_bids = @item.bids
  end

  def edit
  end

  def update
    if @item.save
      redirect_to @item
    else
      render 'edit'
    end
  end

  private
  def item_params
    params.require(:item).permit(:user_id, :title, :description, :default_image, :duration, :base_price, :status)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
