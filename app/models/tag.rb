# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tag < ApplicationRecord
  # アソシエーション？
  # タグから掲示板を関連付ける
  has_many :blog_tag_relations, dependent: :delete_all

  # through: :blog_tag_relations -> blog_tag_relationsを中継してblogと関連づける為の設定
  has_many :blogs, through: :blog_tag_relations
end
