class Forecast < ApplicationRecord
  belongs_to :city

  validates :date, presence: true
  validates :response, presence: true
  validates :min_temperature, presence: true, numericality: true
  validates :max_temperature, presence: true, numericality: true
  validates :unit, presence: true, inclusion: { in: %w[C F] }

  before_validation :set_attributes

  private

  def set_attributes
    return unless response.present?

    temperature = response["Temperature"]
    minimum = temperature["Minimum"]

    self.min_temperature = minimum["Value"]
    self.max_temperature = temperature["Maximum"]["Value"]
    self.unit = minimum["Unit"]
  end
end
