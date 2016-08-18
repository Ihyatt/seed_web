require 'rails_helper'

RSpec.describe APIKeyPolicy do
  subject { APIKeyPolicy.new(user, api_key) }

  let(:api_key) { FactoryGirl.build(:api_key) }
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

  context 'being the api key user' do
    let(:api_key) { FactoryGirl.build(:api_key, user: user) }

    it { should permit_action(:show) }
    it { should forbid_action(:update) }
    it { should permit_action(:destroy) }
  end

end

