require 'rails_helper'

RSpec.describe Conversation, type: :model do
  let(:conversation) { FactoryGirl.build(:conversation) }

  subject { conversation }

  describe "associations" do
    it { should have_many :messages }
    it { should have_many(:users).through(:messages) }
    it { should belong_to(:customer) }
  end

  describe 'validations' do
    it { should validate_presence_of(:slug) }
    it { should validate_uniqueness_of(:slug) }

    it { should validate_presence_of(:customer) }
    it { should validate_uniqueness_of(:customer_id) }
  end

  describe "users" do
    let(:user1) {FactoryGirl.build(:user)}
    let(:user2) {FactoryGirl.build(:user)}
    let(:user3) {FactoryGirl.build(:user)}
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

  describe "customer" do
    let(:user) { FactoryGirl.create(:user)}
    it "should create only conversation for a customer" do
      conversation1 = Conversation.create_for_customer(user)
      conversation2 = Conversation.create_for_customer(user)

      expect(Conversation.count).to eq(1)
      expect(conversation1).not_to be_nil
      expect(conversation2).not_to be_nil
      expect(conversation1).to eq(conversation2)
    end
  end
end
