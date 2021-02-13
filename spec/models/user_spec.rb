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
require 'rails_helper'

RSpec.describe User, type: :model do
  # テストを保留しておく為のもの
  # pending "add some examples to (or delete) #{__FILE__}"

  describe '#age' do
    # moc
    # テストが実行される前に必要な準備を行う
    before do
      # テスト実行時点の日付を2018/4/1としている
      allow(Time.zone).to receive(:now).and_return Time.zone.parse("2018/04/01")
    end
    # どういう条件下で行うテストなのかを記載  
    context '20年前の生年月日' do
      let(:user) { User.new(birthday: Time.zone.now - 20.years) }

      # 最終的にどういう状況であるか
      it '年齢が20歳であること' do
        # user -> letで生成
        # rspec マッチャーで検索
        expect(user.age).to eq 20
      end
    end

        context '10年前に生まれた場合でちょうど誕生日の場合' do
      let(:user) { User.new(birthday: Time.zone.parse('2008/04/01')) }

      it '年齢が10歳であること' do
        expect(user.age).to eq 10
      end
    end

    context '10年前に生まれた場合で誕生日が来ていない場合' do
      # ここでの設定は誕生日は4/2
      let(:user) { User.new(birthday: Time.zone.parse('2008/04/02')) }

      it '年齢が9歳であること' do
        expect(user.age).to eq 9
      end
    end
  end
end
# テスト実行コマンド
# bundle exec rspec ./spec/models/
