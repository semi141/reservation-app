class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Devise のコントローラが呼ばれたときだけ実行
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # サインアップ時に :name を許可
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    # アカウント更新時にも :name を許可
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  # ログイン後のリダイレクト先
  def after_sign_in_path_for(resource)
    root_path  # home#index にリダイレクト
  end

  # ログアウト後のリダイレクト先
  def after_sign_out_path_for(resource_or_scope)
    root_path  # home#index にリダイレクト
  end
end