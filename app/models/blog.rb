# == Schema Information
#
# Table name: blogs
#
#  id         :integer          not null, primary key
#  body       :text
#  name       :string
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Blog < ApplicationRecord
  # これを書くことによってblogオブジェクトからコメントが参照できるようになる
  # dependent: :delete_all -> blogを削除したときに関連するデータ(コメント、タグ)も一緒に削除される
  # delete_allのほかにdestroyもあるが、それは関連するモデルのオブジェクト一つずつに対してdestroyメソッドを呼ぶ
  # 複雑なことをしない限りdelete_allでまとめて削除した方がパフォーマンスがいい
  has_many :comments, dependent: :delete_all

  # ブログからタグを関連付ける
  has_many :blog_tag_relations, dependent: :delete_all
  has_many :tags, through: :blog_tag_relations
  validates :name, presence: true, length: { maximum: 10 }
  validates :title, presence: true, length: { maximum: 30 }
  validates :body, presence: true, length: { maximum: 1000 }
end
