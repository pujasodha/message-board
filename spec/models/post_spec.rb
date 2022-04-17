require 'rails_helper'

describe Post, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, user: user, created_at: Time.now) }

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:message) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'passes validation' do
    it 'creats post' do
      expect(post).to be_valid
    end

    it 'does not create comment' do
      post.message = nil

      expect(post).to_not be_valid
    end
  end

  describe '#time_created' do
    it 'converts time for readability' do
      expect(post.time_created).to eq(Time.now.strftime('%B %d, %Y'))
    end
  end
end
