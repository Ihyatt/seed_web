class Question < ApplicationRecord
  belongs_to :survey
  has_many :responses, dependent: :destroy, inverse_of: :question
  accepts_nested_attributes_for :responses, reject_if: :all_blank, allow_destroy: true

  validates :survey, presence: true
  validates :title, presence: true
end
