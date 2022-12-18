# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "投稿のテスト", selenium: true do
  let!(:member){ FactoryBot.create(:member) }
  let!(:beer){ FactoryBot.create(:beer) }
  let!(:post){ FactoryBot.create(:post) }
  describe '新規投稿画面のテスト' do
    before do
      sign_in member
      visit new_post_path(selected_beer: beer.id)
    end
    context '投稿処理に関するテスト' do
      it '投稿に成功しサクセスメッセージが表示されるか' do
        click_button '投稿'
        expect(page).to have_content '完了'
      end
      it '投稿に失敗する' do
        fill_in 'post[content]', with: Faker::Lorem.characters(number:501)
        click_button '投稿'
        expect(page).to have_content '確認してください'
        expect(current_path).to eq(new_post_path)
      end
      it '投稿後のリダイレクト先は正しいか' do
        click_button '投稿'
        expect(page).to have_current_path mypage_path
      end
    end
    context '投稿削除のテスト' do
      it '投稿の削除' do
        expect{ post.destroy }.to change{ Post.count }.by(-1)
      end
    end
  end
end