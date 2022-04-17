require 'rails_helper'

describe Comment, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, user: user) }
  let(:comment) { FactoryBot.create(:comment, post: post, user: user) }

  describe 'validations' do
    it { should validate_presence_of(:body) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:post) }
  end

  describe 'passes validation' do
    it 'creats comment' do
      expect(comment).to be_valid
    end

    it 'does not create comment' do
      comment.body = nil

      expect(comment).to_not be_valid
    end
  end
end
