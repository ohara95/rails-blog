# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  birthday        :date
#  name            :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_name  (name) UNIQUE
#
class User < ApplicationRecord
  # userモデルに認証機能を持たせるために記述
  has_secure_password

  validates :name,
            # 入力必須
            presence: true,
            # 同じ名前の登録NG
            uniqueness: true,
            length: {
              maximum: 16,
            },
            format: {
              with: /\A[a-z0-9]+\z/,
              # エラー時にデフォルトエラーが「不正な入力」の為明示的にエラー分を設定
              message: 'は小文字英数字で入力してください',
            }

  # 最低文字数のバリデーションを設定するとpresenceを設定しなくても
  # 空の入力でエラーがでるようになる
  validates :password, length: { minimum: 8 }

  def age
    # 日本の現在時間
    now = Time.zone.now
    # 10_000で割って年数を取得
    (now.strftime('%Y%m%d').to_i - birthday.strftime('%Y%m%d').to_i) / 10_000
  end
end
