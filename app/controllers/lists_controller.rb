class ListsController < ApplicationController
  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
    @bookmarks = Bookmark.all
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(lists_params)
    if @list.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @list = List.find(lists_params)
    @list.destroy
  end

  private

  def lists_params
    params.require(:list).permit(:name, :address, :phone_number, :category)
  end
end
