class Public::RecipesController < ApplicationController
  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.customer_id = current_customer.id

    if @recipe.save
      redirect_to public_recipe_path(@recipe)
    else
      render :new
    end

  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def index
  end

  def edit
  end

  def update
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :material, :making, :message)
  end

end
