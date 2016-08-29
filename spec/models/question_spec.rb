require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question) { FactoryGirl.build(:question) }

  subject { question }

  describe "associations" do
    it { should belong_to :survey }
    it { should have_many :responses}
  end

  describe 'validations' do
    it { should validate_presence_of(:survey) }
    it { should validate_presence_of(:title) }
  end
end
