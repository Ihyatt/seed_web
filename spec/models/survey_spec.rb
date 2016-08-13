require 'rails_helper'

RSpec.describe Survey, type: :model do
  let(:survey) { FactoryGirl.build(:survey) }

  describe "associations" do
    it { should have_many :questions }
  end

  describe 'validations' do
    it { should validate_presence_of(:user) }
  end
end
