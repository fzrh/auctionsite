class PagesController < ApplicationController
  def index
    @items = Item.all
  end
end
