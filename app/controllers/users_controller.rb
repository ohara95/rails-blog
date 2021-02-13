class UsersController < ApplicationController
  def new
    # createのバリデーションエラーでホームに戻された場合も
    # 引数にしてしておくことで入力したユーザー名が消えずに残る
    @user = User.new(flash[:user])
  end

  # formをsubmitしたらcreateメソッドが呼ばれる
  def create
    # フォームから送信されてたuserのパラメーターから新しいuserオブジェクトを作成
    user = User.new(user_params)

    # パスワードとパスワード再入力が一致しているかもバリデーションしてくれる
    if user.save
      # session変数はsession情報を扱う為の特殊な変数で
      # session変数の任意のキーに値をセットすることで
      # ページを跨いで変数の値を保持することができる
      session[:user_id] = user.id
      redirect_to mypage_path
    else
      # ホーム画面に戻す
      flash[:user] = user
      flash[:error_messages] = user.errors.full_messages
      redirect_back fallback_location: 'http://localhost'
      # redirect_to :back,
      #             flash: {
      #               user: user,
      #               error_messages: user.errors.full_messages,
      #             }
    end
  end

  def me; end

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end
end
