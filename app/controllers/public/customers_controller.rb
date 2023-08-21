class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
    @recipes = @customer.recipes
    bookmarks = Bookmark.where(customer_id: current_customer.id).pluck(:recipe_id)
    @bookmarks = Recipe.find(bookmarks)
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customers_mypage_path notice: "登録情報を更新しました。"
    else
      render :edit
    end
  end

  def check
  end

  def withdrawal
  end

  private

  def customer_params
    params.require(:customer).permit(:email, :last_name, :first_name, :last_name_kana, :first_name_kana)
  end
end
