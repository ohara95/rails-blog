# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  comment    :text             not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  blog_id    :integer
#
# Indexes
#
#  index_comments_on_blog_id  (blog_id)
#
class Comment < ApplicationRecord
  belongs_to :blog
  validates :name, presence: true, length: { maximum: 10 }
  validates :comment, presence: true, length: { maximum: 1000 }
end
