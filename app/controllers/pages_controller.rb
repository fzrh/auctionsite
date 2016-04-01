class PagesController < ApplicationController
  def index
    @current_listings = Listing.current
    @ended_listings = Listing.ended
  end
end
