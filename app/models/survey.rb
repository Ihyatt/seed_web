class Survey < ApplicationRecord
  # Associations
  has_many :questions, dependent: :destroy, inverse_of: :survey
  belongs_to :user

  validates :user, presence: true
end
