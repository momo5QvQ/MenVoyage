class Public::CommentsController < ApplicationController
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = current_customer.comments.new(comment_params)
    @comment.recipe_id = @recipe.id
    if @comment.save
      @comment = Comment.new
    end
  end

  def destroy
    # Comment.find(id: params[:id], recipe_id: params[:recipe_id]).destroy
    # @recipe = Recipe.find(params[:recipe_id])
    comment = Comment.find_by(id: params[:id], recipe_id: params[:recipe_id])
    if comment && comment.customer == current_customer #コメントとコメントユーザー＝ログインユーザー
      comment.destroy
    end
    @recipe = Recipe.find(params[:recipe_id])
    @comment = Comment.new
  end

  private

   def comment_params
     params.require(:comment).permit(:comment)
   end
end
