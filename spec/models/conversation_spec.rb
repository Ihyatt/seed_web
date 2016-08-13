require 'rails_helper'

RSpec.describe Conversation, type: :model do
  let(:conversation) { FactoryGirl.build(:user) }

  describe "associations" do
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:slug) }
    it { is_expected.to validate_uniqueness_of(:slug) }
  end
end
