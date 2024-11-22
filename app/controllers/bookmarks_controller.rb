class BookmarksController < ApplicationController
  def new
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
  end

  def create
    @list = List.find(params[:list_id])
    @bookmark = @list.bookmarks.new(bookmark_params)

    if @bookmark.save
      redirect_to list_path(@list), notice: "Movie successfully added to the list!"
    else
      @reviews = @list.reviews
      @movies = Movie.all - @list.movies
      render 'lists/show', status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    if @bookmark.destroy
      redirect_to list_path(@bookmark.list), notice: "Movie successfully removed from the list!"
    else
      redirect_to list_path(@bookmark.list), alert: "Failed to remove the movie. Please try again."
    end
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:movie_id, :comment)
  end
end
