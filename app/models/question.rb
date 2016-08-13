class Question < ApplicationRecord
  belongs_to :survey

  validates :survey, presence: true
  validates :title, presence: true
end
