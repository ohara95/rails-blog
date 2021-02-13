module ApplicationHelper
  # アプリ全体で使用するヘルパーメソッドを記述
  # 特定のコントローラーのviewで使用されるヘルパーなら名前を合わせたフォルダに記述した方が分かりやすい

  def header_link_item(name, path)
    # bootstrapに合わせる為記述
    class_name = 'nav-item'

    # current_page?(path) -> 表示するpathと引数のpathが同一か判断
    # 同じならクラスの指定にactiveを追加
    class_name << ' active' if current_page?(path)

    # 任意のhtmlタグを作る
    content_tag :li, class: class_name do
      link_to name, path, class: 'nav-link'
    end
  end
end
