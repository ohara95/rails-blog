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
  has_many :comments
  validates :name, presence: true, length: { maximum: 10 }
  validates :title, presence: true, length: { maximum: 30 }
  validates :body, presence: true, length: { maximum: 1000 }
end
