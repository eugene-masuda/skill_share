require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:user) { create(:user, admin: true) }
  let!(:other) { create(:user, password: "password") }

  context 'when editing without logging in' do
    it 'redirect to new_user_session_path' do
      get edit_user_registration_path
      expect(response).to redirect_to new_user_session_path
    end
  end

  context 'when updating without logging in' do
    it 'redirect to new_user_session_path' do
      patch user_registration_path
      expect(response).to redirect_to new_user_session_path
    end
  end

  context 'when deleting without logging in' do
    it 'redirect to new_user_session_path' do
      expect { delete user_registration_path }.not_to change(User, :count)
      expect(response).to redirect_to new_user_session_path
    end
  end

  context 'when visit following page without logging in' do
    it 'redirect to new_user_session_path' do
      get following_user_path(user)
      expect(response).to redirect_to new_user_session_path
    end
  end

  context 'when visit followers  page without logging in' do
    it 'redirect to new_user_session_path' do
      get followers_user_path(user)
      expect(response).to redirect_to new_user_session_path
    end
  end

  context 'when editing  with log in as wrong user' do
    it 'show alert messages' do
      log_in_as other
      get edit_user_registration_path(user)
      expect(response.body).to eq 'アカウント登録もしくはログインしてください。'
    end
  end

  context 'when updating with log in as wrong user' do
    it 'show alert messages' do
      log_in_as other
      patch user_registration_path(user)
      expect(response.body).to eq 'アカウント登録もしくはログインしてください。'
    end
  end

  context 'when deleting with log in as non admin user' do
    it 'redirect to new_user_session_path' do
      log_in_as other
      expect { delete user_path(user) }.not_to change(User, :count)
      expect(response).to redirect_to new_user_session_path
    end
  end

  context 'When admin attribute is edited via web' do
    it 'does not change' do
      log_in_as other
      expect(other.reload.admin).to be_falsey
      patch user_registration_path(other), params: { user:
        {
          password: "password",
          password_confirmation: "password",
          admin: true,
        } }
      expect(other.reload.admin).to be_falsey
    end
  end
end
