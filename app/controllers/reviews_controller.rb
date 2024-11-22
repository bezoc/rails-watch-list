class ReviewsController < ApplicationController
  def create
    @list = List.find(params[:list_id])
    @review = @list.reviews.new(review_params)
    if @review.save
      redirect_to list_path(@list), notice: 'Review successfully added!'
    else
      @bookmark = Bookmark.new
      @reviews = @list.reviews
      render 'lists/show', status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:comment, :rating)
  end
end
