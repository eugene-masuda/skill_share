require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user_a) { create(:user) }
  let(:user_b) { create(:user) }
  let(:test) { create(:test, user: user_b) }
  let(:comment) { build(:comment, user: user_a, test: test) }

  it 'is valid with content' do
    expect(comment).to be_valid
  end

  it 'is invalid without content' do
    comment.content = ''
    expect(comment).to be_invalid
  end
end
