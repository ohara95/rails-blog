class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      # foreign_key  blogテーブルに存在しないidをコメントテーブルに保存できなくする　データ不整合を起こさないために必ず紐づける必要があるから
      t.references :blog, foreign_key: true
      t.string :name, null: false
      t.text :comment, null: false

      t.timestamps
    end
  end
end
