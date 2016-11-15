require 'rails_helper'

RSpec.describe Incident, type: :model do
  let(:incident) { FactoryGirl.build(:incident) }
  let(:reaction) { FactoryGirl.create(:reaction) }
  let(:reaction2) { FactoryGirl.create(:reaction) }

  subject { incident }

  describe "associations" do
    it { should belong_to(:user) }
    it { should have_many(:attachments).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:slug) }
    it { should validate_uniqueness_of(:slug) }

    it { should validate_presence_of(:user) }
    it { should validate_numericality_of(:rating).is_greater_than_or_equal_to(1).allow_nil }
    it { should validate_numericality_of(:rating).is_less_than_or_equal_to(5).allow_nil }

    it "should be valid only with approved reactions",focus: true do
      incident.reactions = [reaction.name, reaction2.name]
      incident.save

      expect(incident).to be_valid

      incident.reactions = ["foo"]
      expect(incident).not_to be_valid

      incident.reactions_list = "bar, dog"
      expect(incident).not_to be_valid
    end
  end


  describe "reactions" do
    it "should be able to set reactions as array" do
      incident.reactions = [reaction.name, reaction2.name]
      incident.save

      expect(incident.reactions.count).to eq 2
      expect(incident.reactions).to include(reaction.name)
      expect(incident.reactions).to include(reaction2.name)

      incidents = Incident.with_any_reactions(reaction.name)
      expect(incidents.count).to eq(1)
    end

    it "should be able to set reactions as string" do
      incident.reactions_list = "#{reaction.name}, #{reaction2.name}"
      incident.save

      expect(incident.reactions.count).to eq 2
      expect(incident.reactions).to include(reaction.name)
      expect(incident.reactions).to include(reaction2.name)
    end

  end
end