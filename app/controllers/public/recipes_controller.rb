class Public::RecipesController < ApplicationController
  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.customer_id = current_customer.id
    #:recipeはrecipeで投稿されてきた際にパラメーターとして飛ばされ、その中の[:tag_id]を取得して、splitで,区切りにしている
    tags = params[:recipe][:tag_list].split(',')

    if @recipe.save
      #@recipeをつけることpostモデルの情報を.save_tagsに引き渡してメソッドを走らせることができる
      @recipe.save_tags(tags)
      redirect_to recipe_path(@recipe), notice:'投稿が完了しました' #確認ダイアログ表示
    else
      render :new
    end

  end

  def show
    @recipe = Recipe.find(params[:id])
    # タグ
    @tags = @recipe.tags.pluck(:name).join(',')
    @recipe_tags = @recipe.tags
    @comment = Comment.new
  end

  def search_tag
    #検索結果画面でもタグ一覧表示
    @tags = Tag.all
    #検索されたタグを受け取る
    @tag = Tag.find(params[:tag_id])
    #検索されたタグに紐づく投稿を表示
    @recipe = @tag.recipes
  end

  def index
    @recipes = Recipe.all
    @tags = Tag.all
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @tags = @recipe.tags.pluck(:name).join(',')
  end

  def update
    @recipe = Recipe.find(params[:id])
    #:postはrecipeで投稿されてきた際にパラメーターとして飛ばされ、その中の[:tag_id]を取得して、splitで,区切りにしている
    tags = params[:recipe][:tag_list].split(',')
    if @recipe.update(recipe_params)
      #@recipeをつけることrecipeモデルの情報を.save_tagsに引き渡してメソッドを走らせることができる
      @recipe.update_tags(tags)
      flash[:notice] = "レシピ内容を更新しました。"
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    if @recipe.destroy
      flash[:notice] = "レシピを削除しました。"
      redirect_to recipes_path
    else
      render :destroy
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :image, :material, :making, :message)
  end

end
