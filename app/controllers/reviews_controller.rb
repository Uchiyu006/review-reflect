class ReviewsController < ApplicationController
  def index
    @reviews = Review.includes(:user)
  end
end
