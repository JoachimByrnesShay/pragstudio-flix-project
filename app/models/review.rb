# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  scope :past_n_days, ->(max) {where("created_at >= ?", max.days.ago)}

  STARS = (1..5).freeze
  # validates :name, presence: true
  validates :comment, length: { minimum: 4 }
  validates :stars, inclusion: { in: STARS,
                                 message: 'must be between 1 and 5' }

  def stars_as_percent
    (stars / 5.0) * 100.0
  end
end
