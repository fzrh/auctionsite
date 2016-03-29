class PagesController < ApplicationController
  def index
    @current_listings = Item.current
    @ended_listings = Item.ended
  end
end
