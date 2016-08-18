require 'rails_helper'

RSpec.describe SurveyPolicy do
  subject { SurveyPolicy.new(user, survey) }

  let(:survey) { FactoryGirl.build(:survey) }
  let(:user) { FactoryGirl.build(:user) }

  context 'being a visitor' do
    let(:user) { nil }

    it { should permit_action(:show) }
    it { should forbid_action(:update) }
    it { should forbid_action(:destroy) }
  end

  context 'being a user' do
    it { should permit_action(:show) }
    it { should forbid_action(:update) }
    it { should forbid_action(:destroy) }
  end

  context 'being the survey user' do
    let(:survey) { FactoryGirl.build(:survey, user: user) }

    it { should permit_action(:show) }
    it { should permit_action(:update) }
    it { should permit_action(:destroy) }
  end

end
