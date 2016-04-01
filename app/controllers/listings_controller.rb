class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update]

  def new
    @listing = Listing.new
  end

  def create
    @listing = current_user.listings.new(listing_params)
    if @listing.save
      redirect_to @listing, notice: 'Listing created!'
    else
      render 'new', error: 'Create failed. Try again?'
    end
  end

  def show
    @bid = Bid.new
    @listing_bids = @listing.bids
  end

  def edit
  end

  def update
    if @listing.update(listing_params)
      redirect_to @listing, notice: 'Listing updated!'
    else
      render 'edit', error: 'Update error. Try again?'
    end
  end

  private
  def listing_params
    params.require(:listing).permit(:user_id, :title, :description, :default_image, :duration, :base_price, :status, :final_price, :end_date)
  end

  def set_listing
    @listing = Listing.find(params[:id])
  end
end
