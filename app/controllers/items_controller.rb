class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update]

  def new
    @item = Item.new
  end

  def create
    @item = current_user.items.new(item_params)
    if @item.save
      redirect_to @item, notice: 'Item created!'
    else
      render 'new', error: 'Create failed. Try again?'
    end
  end

  def show
    @bid = Bid.new
    @item_bids = @item.bids
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to @item, notice: 'Item updated!'
    else
      render 'edit', error: 'Update error. Try again?'
    end
  end

  private
  def item_params
    params.require(:item).permit(:user_id, :title, :description, :default_image, :duration, :base_price, :status, :final_price, :end_date)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
