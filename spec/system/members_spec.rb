# frozen_string_literal: true

require 'rails_helper'

describe "ログイン前のテスト" do
  describe 'トップページのテスト' do
    before do
      visit root_path
    end
    context '表示内容に関するテスト' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end
      it 'ゲストログインのボタンが表示されている' do
        guest_login_link = find_all('a.btn-top')[0].native.inner_text
        expect(guest_login_link).to have_content "ゲストログイン"
      end
      it 'ログインのリンクが表示されている' do
        sign_in_link = find_all('a.btn-top')[1].native.inner_text
        expect(sign_in_link).to have_content "ログイン"
      end
      it '新規会員登録のリンクが表示されている' do
        sign_up_link = find_all('a.btn-top')[2].native.inner_text
        expect(sign_up_link).to have_content "新規会員登録"
      end
    end

    context 'リンクに関するテスト' do
      it 'ログインのリンクからログイン画面に遷移する' do
        find_all('a.btn-top')[1].click
        expect(page).to have_current_path new_member_session_path
      end
      it '新規会員登録のリンクから新規会員登録画面に遷移する' do
        find_all('a.btn-top')[2].click
        expect(page).to have_current_path new_member_registration_path
      end
    end

    context 'ゲストログインに関するテスト', selenium: true do
      it 'フラッシュメッセージが表示される' do
        find_all('a.btn-top')[0].click
        expect(page).to have_content 'ゲストとしてログイン'
      end
      it 'マイページに遷移する' do
        find_all('a.btn-top')[0].click
        expect(page).to have_current_path mypage_path
      end
      it 'アカウント名が「guestuser」になっている' do
        find_all('a.btn-top')[0].click
        expect(page).to have_content '@guestuser'
      end
    end
  end

  describe 'ヘッダーのテスト：ログインしていない場合' do
    before do
      visit root_path
    end
    context '表示内容に関するテスト' do
      it 'ロゴ画像が表示されている' do
        logo = find_all('img')[0].native["src"]
        expect(logo).to have_content("logo")
      end
      it '「ビールを探す」のリンクが表示されている' do
        beer_link = find_all('a')[1].native.inner_text
        expect(beer_link).to have_content "ビールを探す"
      end
      it 'ログインのリンクが表示されている' do
        sign_in_link = find_all('a')[2].native.inner_text
        expect(sign_in_link).to have_content "ログイン"
      end
      it '会員登録のリンクが表示されている' do
        sign_up_link = find_all('a')[3].native.inner_text
        expect(sign_up_link).to have_content "会員登録"
      end
    end

    context 'リンクに関するテスト' do
      it 'ロゴ画像をクリックするとトップページに遷移する' do
        find_all('img')[0].click
        expect(page).to have_current_path root_path
      end
      it '「ビールを探す」をクリックするとビール一覧画面に遷移する' do
        find_all('a')[1].click
        expect(page).to have_current_path beers_path
      end
      it '「ログイン」をクリックするとログイン画面に遷移する' do
        find_all('a')[2].click
        expect(page).to have_current_path new_member_session_path
      end
      it '「会員登録」をクリックすると新規会員登録画面に遷移する' do
        find_all('a')[3].click
        expect(page).to have_current_path new_member_registration_path
      end
    end
  end

  describe 'ビール一覧画面のテスト：ログインしていない場合' do
    let!(:beer1) { create(:beer, name: 'hoge1', evaluation: 3) }
    let!(:beer2) { create(:beer, name: 'hoge2', evaluation: 4) }
    let!(:beer3) { create(:beer, name: 'hoge3', evaluation: 5) }
    before do
      visit beers_path
    end
    context '表示内容に関するテスト' do
      it 'URLが正しい' do
        expect(beers_path).to eq '/beers'
      end
      it '投稿ボタンが表示されていない' do
        expect(page).not_to have_button '投稿'
      end
      it 'ビールが評価の降順で並んでいる' do
        beer = find_all('a')[4].native.inner_text
        expect(beer).to have_content "hoge3"
        beer = find_all('a')[5].native.inner_text
        expect(beer).to have_content "hoge2"
        beer = find_all('a')[6].native.inner_text
        expect(beer).to have_content "hoge1"
      end
      #it '「ビール名で検索」欄にビール名を入力して検索すると正しい検索結果が得られる' do
        #fill_in 'beer_search[beer_search]', with: 'hoge1'
    end
  end
end