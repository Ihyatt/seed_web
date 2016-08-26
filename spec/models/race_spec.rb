require 'rails_helper'

RSpec.describe Race, type: :model do
  let(:race) { FactoryGirl.build(:race) }

  describe "associations" do
    it { should have_many :users }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
