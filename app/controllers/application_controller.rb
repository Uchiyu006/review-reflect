class ApplicationController < ActionController::Base
  before_action :require_login
  add_flash_types :success, :danger

  def not_authenticated
    redirect_to login_path, danger: "ログインしてください"
  end
end
