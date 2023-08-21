class Public::BookmarksController < ApplicationController
  before_action :authenticate_customer!

  def create
    @bookmark = current_customer.bookmarks.build(bookmark_params)
    @recipe = @bookmark.recipe
    if @bookmark.valid?
      @bookmark.save
      redirect_to recipe_path(@recipe), notice: "お気に入りに登録しました。"
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @recipe = @bookmark.recipe
    if @bookmark.destroy
      redirect_to recipe_path(@recipe), notice: "お気に入り登録を解除しました。"
    end
  end

  private
  def bookmark_params
    params.permit(:recipe_id)
  end
end
