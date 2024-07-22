class ReviewsController < ApplicationController
  def index
    @reviews = current_user.reviews
  end

  def new
    session[:review_id] = nil
  end
end
