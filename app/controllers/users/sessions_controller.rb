class Users::SessionsController < Devise::SessionsController
  respond_to :html

  def create
    puts "========== params =========="
    puts params.inspect
    puts "============================"
    super
  end

  protected

  def after_sign_in_path_for(resource)
    root_path  # home#index に飛ばす
  end
end
