require 'rails_helper'

RSpec.describe APIKey, type: :model do
  let(:api_key) { FactoryGirl.build(:api_key) }

  describe "associations" do
    it { should belong_to :user }
  end

  describe 'validations' do
    it { should validate_presence_of(:user) }

    it { should validate_presence_of(:read_key) }
    #it { should validate_uniqueness_of(:read_key) }

    it { should validate_presence_of(:write_key) }
    #it { should validate_uniqueness_of(:write_key) }

    it "should create a read key",focus: true do
      api_key = APIKey.new
      expect(api_key.read_key).not_to be_nil

      puts api_key.inspect
    end
  end
end
