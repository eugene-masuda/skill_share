require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'validation' do
    let(:user) { create(:user) }
    let(:order) { create(:order) }

    it 'is valid with correct info' do
      expect(order).to be_valid
    end
    it 'is invalid without user id' do
      order.user_id = nil
      expect(order).to be_invalid
    end
    it 'is invalid without date' do
      order.date = nil
      expect(order).to be_invalid
    end
    it 'is invalid without public' do
      order.public = nil
      expect(order).to be_invalid
    end
    it 'is invalid without done' do
      order.done = nil
      expect(order).to be_invalid
    end
  end

  describe 'order' do
    context 'when done tickets' do
      let!(:order_a) { create(:order, date: Time.current.ago(10.day), done: true) }
      let!(:order_b) { create(:order, date: Time.current.ago(3.year), done: true) }
      let!(:order_c) { create(:order, date: Time.current.ago(2.month), done: true) }

      it 'sorts by newest date' do
        expect(Ticket.all.done.to_a).to eq [order_a, order_c, order_b]
      end
    end

    context 'when upcomming order' do
      let!(:order_a) { create(:order, date: Time.current.since(10.day), done: false) }
      let!(:order_b) { create(:order, date: Time.current.since(3.year), done: false) }
      let!(:order_c) { create(:order, date: Time.current.since(2.month), done: false) }

      it 'sorts by oldest date' do
        expect(Order.all.upcomming.to_a).to eq [order_a, order_c, order_b]
      end
    end

    context 'when unsolved order' do
      let!(:order_a) { create(:order, date: Time.current.ago(10.day), done: false) }
      let!(:order_b) { create(:order, date: Time.current.ago(3.year), done: false) }
      let!(:order_c) { create(:order, date: Time.current.ago(2.month), done: false) }

      it 'sorts by newest date' do
        expect(Order.all.unsolved.to_a).to eq [order_a, order_c, order_b]
      end
    end
  end
end
