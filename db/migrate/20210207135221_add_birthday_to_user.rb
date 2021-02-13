class AddBirthdayToUser < ActiveRecord::Migration[5.2]
  # bundle exec rails g migration AddBirthdayToUser birthday:date
  def change
    add_column :users, :birthday, :date
  end
end
