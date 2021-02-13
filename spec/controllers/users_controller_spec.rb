require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    # getのリクエスト結果がresponseという変数に格納される
    before { get :new }

    it 'レスポンスコードが200であること' do
      expect(response).to have_http_status(:ok)
    end

    it 'newテンプレートをレンダリングすること' do
      expect(response).to render_template :new
    end

    it '新しいuserオブジェクトがビューに渡されること' do
      expect(assigns(:user)).to be_a_new User
    end
  end

  describe 'POST #create' do
    before do
      # リファラーがない状態でredirect_to_backをするとエラーになる
      # テストなのでリファラーがない為明示的に作成
      # ここでインスタンス変数を作成するとテストケースで参照することが可能
      @referer = 'http://localhost'
      @request.env['HTTP_REFERER'] = @referer
    end

    context '正しいユーザー情報が渡って来た場合' do
      # params:正しいユーザー情報
      let(:params) do
        {
          user: {
            name: 'user',
            password: 'password',
            password_confirmation: 'password',
          },
        }
      end

      it 'ユーザーが一人増えていること' do
        expect { post :create, params: params }.to change(User, :count).by(1)
      end

      it 'マイページにリダイレクトされること' do
        expect(post :create, params: params).to redirect_to(mypage_path)
      end
    end

    context 'パラメータに正しいユーザー名、確認パスワードが含まれていない場合' do
      before do
        post(:create, params: {
          user: {
            name: 'ユーザー1',
            password: 'password',
            password_confirmation: 'invalid_password'
          }
        })
      end

      it 'リファラーにリダイレクトされること' do
        expect(response).to redirect_to(@referer)
      end

      it 'ユーザー名のエラーメッセージが含まれていること' do
        expect(flash[:error_messages]).to include 'ユーザー名は小文字英数字で入力してください'
      end

      it 'パスワード確認のエラーメッセージが含まれていること' do
        expect(flash[:error_messages]).to include 'パスワード（確認）とパスワードの入力が一致しません'
      end
    end
  end
end
