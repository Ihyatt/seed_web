require 'rails_helper'

RSpec.describe ConversationPolicy do
  subject { ConversationPolicy.new(user, conversation) }

  let(:conversation) { FactoryGirl.build(:conversation) }
  let(:user) { FactoryGirl.build(:user) }

  context 'being a visitor' do
    let(:user) { nil }

    it { should forbid_action(:show) }
    it { should forbid_action(:update) }
    it { should forbid_action(:destroy) }
  end

  context 'being a user' do
    it { should forbid_action(:show) }
    it { should forbid_action(:update) }
    it { should forbid_action(:destroy) }
  end

  context 'being the conversation customer' do
    let(:conversation) { FactoryGirl.build(:conversation, customer: user) }

    it { should permit_action(:show) }
    it { should forbid_action(:update) }
    it { should forbid_action(:destroy) }
  end

  context 'being an admin' do
    let(:user) { FactoryGirl.build(:admin) }

    it { should permit_action(:show) }
    it { should permit_action(:update) }
    it { should permit_action(:destroy) }
  end

end
