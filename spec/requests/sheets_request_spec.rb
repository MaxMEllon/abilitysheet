require 'rails_helper'

RSpec.describe SheetsController, type: :request do
  let(:user) { create(:user, id: 1) }
  context 'ログイン時' do
    before { login_as(user, scope: :user, run_callbacks: false) }

    it 'ログインしている' do
      visit root_path
      expect(page).to have_link('ログアウト')
    end

    describe 'ハード参考表ページ' do
      before { visit sheet_path(iidxid: user.iidxid, type: 'hard') }
      it 'ハード参考表の文字が存在する' do
        expect(page).to have_content('ハード参考表')
      end
      it 'クリア参考表のリンクが存在する' do
        expect(page).to have_link('CLEAR', sheet_path(iidxid: user.iidxid, type: 'clear'))
      end
    end

    describe 'ノマゲ参考表ページ' do
      before { visit sheet_path(iidxid: user.iidxid, type: 'clear') }
      it 'ノマゲ参考表の文字が存在する' do
        expect(page).to have_content('ノマゲ参考表')
      end
      it 'ハード参考表のリンクが存在する' do
        expect(page).to have_link('HARD', sheet_path(iidxid: user.iidxid, type: 'hard'))
      end
    end

    describe '地力値参考表ページ' do
      before { visit sheet_path(iidxid: user.iidxid, type: 'power') }
      it 'iidx.meの文字が存在する' do
        expect(page).to have_content('iidx.me')
      end
    end
  end

  context '非ログイン時' do
    it 'ログインしていない' do
      visit root_path
      expect(page).to have_link('ログイン')
    end

    describe 'ハード参考表ページ' do
      before { visit sheet_path(iidxid: user.iidxid, type: 'hard') }
      it 'ハード参考表の文字が存在する' do
        expect(page).to have_content('ハード参考表')
      end
      it 'クリア参考表のリンクが存在する' do
        expect(page).to have_link('CLEAR', sheet_path(iidxid: user.iidxid, type: 'clear'))
      end
    end

    describe 'ノマゲ参考表ページ' do
      before { visit sheet_path(iidxid: user.iidxid, type: 'clear') }
      it 'ノマゲ参考表の文字が存在する' do
        expect(page).to have_content('ノマゲ参考表')
      end
      it 'ハード参考表のリンクが存在する' do
        expect(page).to have_link('HARD', sheet_path(iidxid: user.iidxid, type: 'hard'))
      end
    end

    describe '地力値参考表ページ' do
      before { visit sheet_path(iidxid: user.iidxid, type: 'power') }
      it 'iidx.meの文字が存在する' do
        expect(page).to have_content('iidx.me')
      end
    end
  end
  context '楽曲更新時' do
    before do
      page.driver.allow_url('platform.twitter.com')
      create(:sheet, id: 1, active: true)
      create(:score, id: 1, user_id: 1, sheet_id: 1, state: 6)
      login_as(user, scope: :user, run_callbacks: false)
      visit sheet_path(iidxid: user.iidxid, type: 'clear')
    end

    it 'モーダルが降りてくる', js: true do
      click_on 'MyString'
      expect(page).to have_content('クリア情報更新')
    end

    it '楽曲が更新でき，ログが作られている', js: true do
      expect(Score.find_by(id: 1).state).to eq 6
      expect(Log.exists?(user_id: 1, sheet_id: 1, pre_state: 6, new_state: 3)).to eq false
      click_on 'MyString'
      sleep(1)
      select 'CLEAR', from: 'score_state'
      click_on '更新'
      visit sheet_path(iidxid: user.iidxid, type: 'clear')
      expect(Score.find_by(id: 1).state).to eq 3
      expect(Log.exists?(user_id: 1, sheet_id: 1, pre_state: 6, new_state: 3)).to eq true
    end
  end
end
