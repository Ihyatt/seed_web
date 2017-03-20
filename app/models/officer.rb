class Officer < ApplicationRecord
  belongs_to :incident
  belongs_to :race
  belongs_to :gender

  # Validations
  validates :incident, :presence => true

  def race_name=(value)
    found_record = Race.search_by_exact_name(value).first
    self.race = found_record if found_record.present?
  end

  def gender_name=(value)
    found_record = Gender.search_by_exact_name(value).first
    self.gender = found_record if found_record.present?
  end
end
