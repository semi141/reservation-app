class UsersController < ApplicationController
  before_action :authenticate_user!

  # アカウント表示ページ
  def show_account
    @user = current_user
  end
end
