# == Schema Information
#
# Table name: blog_tag_relations
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  blog_id    :integer
#  tag_id     :integer
#
# Indexes
#
#  index_blog_tag_relations_on_blog_id  (blog_id)
#  index_blog_tag_relations_on_tag_id   (tag_id)
#
require 'test_helper'

class BlogTagRelationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
