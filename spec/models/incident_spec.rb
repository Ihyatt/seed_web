require 'rails_helper'

RSpec.describe Incident, type: :model do
  let(:incident) { FactoryGirl.build(:incident) }

  describe "associations" do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:slug) }
    #it { should validate_uniqueness_of(:slug) }

    it { should validate_presence_of(:user) }
  end


end
