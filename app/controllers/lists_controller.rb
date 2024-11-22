class ListsController < ApplicationController
  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
    @reviews = @list.reviews
    @review = Review.new
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)

    if @list.save
      respond_to do |format|
        format.html { redirect_to @list, notice: 'List was successfully created.' }
        format.turbo_stream do
          render turbo_stream: turbo_stream.append('lists', partial: 'lists/list', locals: { list: @list })
        end
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    redirect_to lists_path, notice: "List deleted successfully!"
  end

  def update
    @list = List.find(params[:id])
    if @list.update(list_params)
      redirect_to list_path(@list), notice: 'List was successfully updated.'
    else
      render :edit, alert: 'Could not update the list.'
    end
  end

  private

  def list_params
    params.require(:list).permit(:name, :photo)
  end
end
