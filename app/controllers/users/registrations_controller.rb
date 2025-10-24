class Users::RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!

  # サインアップ用
  before_action :configure_sign_up_params, only: [:create]

  # -----------------------------
  # アカウント情報編集
  # -----------------------------
  def edit_account
    @user = current_user
  end

  def update_account
    @user = current_user

    # パスワードが空なら current_password なしで更新
    if params[:user][:password].blank?
      if @user.update_without_password(account_update_params.except(:password, :password_confirmation))
        bypass_sign_in(@user)
        redirect_to account_path, notice: 'アカウント情報を更新しました'
      else
        render :edit_account
      end
    else
      # 成功したらアカウント確認ページへリダイレクト
      if @user.update(account_update_params)
        bypass_sign_in(@user)
        redirect_to account_path, notice: "アカウント情報を更新しました"
      else
        render :edit_account
      end
    end
  end


  # -----------------------------
  # プロフィール編集
  # -----------------------------
  def edit_profile
    @user = current_user
  end

  def update_profile
    @user = current_user
    if @user.update(profile_update_params)
      redirect_to root_path, notice: 'プロフィールを更新しました'
    else
      render :edit_profile
    end
  end

  # -----------------------------
  protected

  # サインアップ後に飛ばしたいページ
  def after_sign_up_path_for(resource)
    root_path  # 好きなページに変更できる
  end

  # サインアップ時の追加パラメータ許可
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :icon, :profile])
  end

  # アカウント情報用パラメータ
  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  # プロフィール用パラメータ
  def profile_update_params
    params.require(:user).permit(:name, :icon, :profile)
  end
end
