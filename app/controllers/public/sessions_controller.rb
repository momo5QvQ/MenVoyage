# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # ゲストログイン
  def guest_sign_in
    customer = Customer.guest
    sign_in customer
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  def after_sign_in_path_for(resource)
    recipes_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  protected

  def reject_customer # 会員の論理削除のための記述。退会後は、同じアカウントでは利用できない。
    @customer = Customer.find_by(email: params[:customer][:email])
    #ログイン時に入力されたメールアドレスに対応するユーザーが存在するか探しています。

    if @customer
      if @customer.valid_password?(params[:customer][:password]) && (@customer.is_withdrawal == false)
        flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
        redirect_to new_customer_registration_path
      else
        flash[:notice] = "項目を入力してください"
      end
    else
      flash[:notice] = "ユーザが見つかりません。"
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end
end
