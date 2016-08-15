class Response < ApplicationRecord
  TEXT = "text"
  SINGLE_CHOICE = "single_choice"
  MULTIPLE_CHOICE = "multiple_choice"
  KINDS = [
    TEXT,
    SINGLE_CHOICE,
    MULTIPLE_CHOICE
  ]

  # Scopes
  scope :by_position, -> { order('position DESC') }

  # Assocations
  belongs_to :question

  # Validations
  validates :question, :presence => true
  validates :kind, presence: true, inclusion: { in: KINDS }

  def is_multiple_choice?
    self.kind == MULTIPLE_CHOICE
  end

  def is_text?
    self.kind == TEXT
  end

  def is_single_choice?
    self.kind == SINGLE_CHOICE
  end
end
