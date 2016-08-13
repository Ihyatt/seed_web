require 'rails_helper'

RSpec.describe Conversation, type: :model do
  let(:conversation) { FactoryGirl.build(:conversation) }

  describe "associations" do
    it { should have_many :messages }
    it { should have_many(:users).through(:messages) }
  end

  describe 'validations' do
    it { should validate_presence_of(:slug) }
    it { should validate_uniqueness_of(:slug) }
  end

  describe "users" do
    let(:user1) {FactoryGirl.create(:user)}
    let(:user2) {FactoryGirl.create(:user)}
    let(:user3) {FactoryGirl.create(:user)}
    it "should get unique users in a conversation" do
      3.times do
        message = FactoryGirl.create(:message, conversation: conversation, user: user1)
        message = FactoryGirl.create(:message, conversation: conversation, user: user2)
        message = FactoryGirl.create(:message, conversation: conversation, user: user3)
      end
      expect(conversation.messages.count).to eq 9
      expect(conversation.users.count).to eq 3
    end
  end
end