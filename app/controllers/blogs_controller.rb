class BlogsController < ApplicationController
  # 実行したいメソッドをシンボルで書く
  before_action :set_target_blog, only: %i[show edit update destroy]

  def index
    # @blogs = Blog.all
    # tag_idに該当するtagを取得してtagオブジェクトから関連するブログを取得
    # tag_idがあった場合にはタグをtag_idから検索してタグに紐付くブログのリストを取得

    @blogs =
      params[:tag_id].present? ? Tag.find(params[:tag_id]).blogs : Blog.all

    # kaminariのインストールによりモデルに対してpageメソッドが使えるようになる
    @blogs = @blogs.page(params[:page])
  end

  def new
    @blog = Blog.new(flash[:blog])
  end

  def create
    blog = Blog.new(blog_params)
    if blog.save
      flash[:notice] = '投稿しました'

      # 作成した時点でIDが付与されるのでblog = blog/:idが実現する
      # viewがないのでリダイレクト
      redirect_to blog
    else
      redirect_to new_blog_path,
                  flash: {
                    # リダイレクトすると入力したフォームが消える為
                    # flashでnewアクションに渡すことで入力したままのフォームを返すことができる
                    # 渡さないと途中までの入力が消える
                    blog: blog,
                    error_messages: blog.errors.full_messages,
                  }
      # flash[:error_messages] ここにはバリデーションエラーが配列の形で格納される
    end
  end

  def show
    # @comment = @blog.comments.new
    # コメントオブジェクトでblog_idが設定されている
    @comment = Comment.new(blog_id: @blog.id)
    # @comment = @blog.comments.new(blog_id: @blog.id)
  end

  def edit
    #.attributes -> オブジェクトの属性情報（id, name, titleなど）をHashの形式で取得するメソッド
    # updateのバリデーションでelse分に入った時に@blogだとエラーが出る
    # Blogクラスのインスタンス以外のもの(フォームで入力した値)が入るためエラーになる
    @blog.attributes = flash[:blog] if flash[:blog]
  end

  def update
    # プロパティ名_値
    # memo updateはnewと違ってsaveとかないからこういう書き方 -> update ≠ save
    if @blog.update(blog_params)
      redirect_to @blog, flash: { notice: '更新できました' }
    else
      redirect_back fallback_location: @blog,
                    flash: {
                      blog: @blog,
                      error_messages: @blog.errors.full_messages,
                    }
    end
  end

  def destroy
    @blog.destroy
    redirect_to blogs_path, flash: { notice: '削除されました' }
  end

  private

  def blog_params
    params.require(:blog).permit(:name, :title, :body, tag_ids: [])
  end

  def set_target_blog
    @blog = Blog.find(params[:id])
  end
end
