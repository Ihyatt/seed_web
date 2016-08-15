require 'rails_helper'

RSpec.describe Response, type: :model do
  let(:response) { FactoryGirl.build(:response)}

  describe "associations" do
    it { should belong_to :question }
  end

  describe 'validations' do
    it { should validate_presence_of(:question) }
    it { should validate_presence_of(:kind) }    
    it { should validate_inclusion_of(:kind).in_array(Response::KINDS) }
  end

    
end
