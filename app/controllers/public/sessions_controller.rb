# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  def after_customer_sign_out_path_for
    about_path
  end

  def after_sign_in_path_for(resource)
    customer_path(current_customer)
  end

  def guest_sign_in
    customer = Customer.guest

    sign_in customer  # ユーザーをログインさせる
    redirect_to customer_path(current_customer), notice: 'ゲストユーザーでログインしました。'
  end

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

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
