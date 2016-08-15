class Response < ApplicationRecord
  TEXT = "text"
  SINGLE_CHOICE = "single_choice"
  MULTIPLE_CHOICE = "multiple_choice"
  KINDS = [
    TEXT,
    SINGLE_CHOICE,
    MULTIPLE_CHOICE
  ]

  # Assocations
  belongs_to :question

  # Validations
  validates :question, :presence => true
  validates :kind, presence: true, inclusion: { in: KINDS }
end
