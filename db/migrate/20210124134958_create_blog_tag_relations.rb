class CreateBlogTagRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :blog_tag_relations do |t|
      t.references :blog, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
  end
end
