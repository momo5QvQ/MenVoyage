class Public::SearchesController < ApplicationController
  before_action :authenticate_customer!#会員の認証が必要

  def search
    @range = params[:range]

    if @range == "Recipe"
      @recipes = Recipe.looks(params[:search], params[:word])
    else
      @tags = Tag.looks(params[:search], params[:word])
    end
  end
end
