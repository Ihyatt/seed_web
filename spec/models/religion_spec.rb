require 'rails_helper'

RSpec.describe Religion, type: :model do
  let(:religion) { FactoryGirl.create(:religion) }

  subject { religion }

  describe "associations" do
    it { should have_many :users }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
    # it { should validate_presence_of(:slug) }
    it { should validate_uniqueness_of(:slug).case_insensitive }
  end
end
