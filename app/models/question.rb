class Question < ApplicationRecord
  # Scopes
  scope :by_position, -> { order('position DESC') }

  # Associations
  belongs_to :survey
  has_many :responses, dependent: :destroy, inverse_of: :question
  accepts_nested_attributes_for :responses, reject_if: :all_blank, allow_destroy: true

  # Validations
  validates :survey, presence: true
  validates :title, presence: true
end
