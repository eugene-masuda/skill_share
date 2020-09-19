require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    let(:user) { build(:user) }

    it 'is valid with valid params' do
      expect(user).to be_valid
    end

    it 'is invalid without name' do
      user.name = ''
      expect(user).to be_invalid
    end

    it 'is invalid with name too long' do
      user.name = 'a' * 51
      expect(user).to be_invalid
    end

    it 'is invalid without email' do
      user.email = ''
      expect(user).to be_invalid
    end

    it 'is valid with email of valid format' do
      user.email = 'user@example.com'
      expect(user).to be_valid
      user.email = 'USER@foo.COM'
      expect(user).to be_valid
      user.email = 'A_US-ER@foo.bar.org'
      expect(user).to be_valid
      user.email = 'first.last@foo.jp'
      expect(user).to be_valid
      user.email = 'alice+bob@baz.cn'
      expect(user).to be_valid
    end

    it 'is invalid with email of invaild format' do
      user.email = 'user@example,com'
      expect(user).to be_invalid
      user.email = 'user_at_foo.org'
      expect(user).to be_invalid
      user.email = 'user.name@example.'
      expect(user).to be_invalid
      user.email = 'foo@bar_baz.com'
      expect(user).to be_invalid
      user.email = 'foo@bar+baz.com'
      expect(user).to be_invalid
    end

    it 'is invalid with not unique email' do
      duplicate_user = user.dup
      duplicate_user.email = user.email.upcase
      user.save!
      expect(duplicate_user).to be_invalid
    end

    it 'saved email as lower-case' do
      mixed_case_email = "Foo@ExAMPle.CoM"
      user.email = mixed_case_email
      user.save!
      expect(user.reload.email).to eq mixed_case_email.downcase
    end

    it 'is invalid with blank password' do
      user.password = user.password_confirmation = '' * 6
      expect(user).to be_invalid
    end

    it 'is invalid with password too short' do
      user.password = user.password_confirmation = 'a' * 5
      expect(user).to be_invalid
    end

    it 'associated tickets are destroyed' do
      user.save
      user.tickets.create!(date: Date.current, done: false)
      expect { user.destroy }.to change(Ticket, :count).by(-1)
    end
  end

  describe 'feed' do
    let(:user_a) { create(:user) }
    let(:user_b) { create(:user) }
    let(:user_c) { create(:user) }
    let(:ticket_self) { create(:ticket, user: user_a) }
    let(:ticket_following) { create(:ticket, user: user_b) }
    let(:ticket_unfollow) { create(:ticket, user: user_c) }

    it 'includes self and following tickets but not includes unfollowing tickets' do
      user_a.follow(user_b)
      expect(user_a.feed).to include(ticket_self)
      expect(user_a.feed).to include(ticket_following)
      expect(user_a.feed).not_to include(ticket_unfollow)
    end
  end

  describe 'analysis' do
    let(:user_a) { create(:user) }
    let(:user_b) { create(:user) }
    let(:user_c) { create(:user) }
    let!(:ticket_a_1) { create(:ticket, user: user_a, artist: 'artist_a', place: 'venue_a') }
    let!(:ticket_a_2) { create(:ticket, user: user_a, artist: 'artist_a', place: 'venue_b') }
    let!(:ticket_a_3) { create(:ticket, user: user_a, artist: 'artist_b', place: 'venue_c') }
    let!(:ticket_a_4) { create(:ticket, user: user_a, artist: 'artist_c', place: 'venue_c') }
    let!(:ticket_b_1) { create(:ticket, user: user_b, artist: 'artist_a') }
    let!(:ticket_b_2) { create(:ticket, user: user_b, artist: 'artist_d') }
    let!(:ticket_b_3) { create(:ticket, user: user_b, artist: 'artist_e') }
    let!(:ticket_c_1) { create(:ticket, user: user_c, artist: 'artist_a') }
    let!(:ticket_c_2) { create(:ticket, user: user_c, artist: 'artist_d') }
    let!(:ticket_c_3) { create(:ticket, user: user_c, artist: 'artist_f') }

    before do
      Ticket.update_all(done: true)
    end

    it 'shows most visited place' do
      expect(user_a.most_visited_places(1).join).to eq 'venue_c'
    end

    it 'shows most visited artist' do
      expect(user_a.most_visited_artists(1).join).to eq 'artist_a'
    end

    it 'suggests artists who other user visted recently' do
      expect(user_a.suggests_related_most_visited_artists(1).join).to eq 'artist_d'
    end
  end
end
