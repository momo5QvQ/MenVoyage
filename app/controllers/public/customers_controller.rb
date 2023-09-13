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

  def withdrawal
    @customer = Customer.find(params[:id])
    #is_withdrawalカラムをtrueに変更することにより削除フラグを立てる
    @customer.update(is_withdrawal: true)
    reset_session #セッション情報を全て削除
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:email, :last_name, :first_name, :last_name_kana, :first_name_kana)
  end
end
