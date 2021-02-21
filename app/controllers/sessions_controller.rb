class SessionsController < ApplicationController
  def create
    # paramsから該当するユーザーを検索して取得
    # 該当するユーザーがいない場合はnilが入る
    user = User.find_by(name: params[:session][:name])

    # 実際に認証を行う
    # userがnilの場合はログインNGでelseに入る
    # user.authenticateでユーザー名とパスワードがマッチしているかを確認
    # authenticate -> has_secure_passwordを使用したことで自動的に追加されるメソッド
    # userかfalseが返る
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to blogs_path
    else
      redirect_to root_path, alert: '入力に誤りがあります'
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end
end
