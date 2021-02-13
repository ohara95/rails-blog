class ApplicationController < ActionController::Base
  # ApplicationControllerは全てのコントローラーで継承している
  # CSRF(クロスサイトリクエストフォージェリ)対策：Webアプリケーションの脆弱性を利用したサイバー攻撃の一種
  protect_from_forgery with: :exception

  # 全てのアクションの前に呼び出される
  before_action :current_user

  private

  def current_user
    # sessionにuser_idがなければreturn
    return unless session[:user_id]
    @current_user = User.find_by(id: session[:user_id])
  end
end
