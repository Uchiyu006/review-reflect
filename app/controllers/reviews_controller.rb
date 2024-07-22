class ReviewsController < ApplicationController
  def index
    @reviews = current_user.reviews
  end

  def new; end
end
