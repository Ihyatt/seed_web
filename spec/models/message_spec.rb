require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:message) { FactoryGirl.build(:message) }

  describe "associations" do
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:conversation) }
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:text) }
    
  end
end
