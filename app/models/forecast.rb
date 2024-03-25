# == Schema Information
#
# Table name: forecasts
#
#  id              :bigint           not null, primary key
#  date            :date             not null
#  max_temperature :decimal(5, 2)    not null
#  min_temperature :decimal(5, 2)    not null
#  response        :jsonb            not null
#  unit            :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  city_id         :bigint           not null
#
class Forecast < ApplicationRecord
  belongs_to :city

  validates :date, presence: true
  validates :response, presence: true
  validates :min_temperature, presence: true, numericality: true
  validates :max_temperature, presence: true, numericality: true
  validates :unit, presence: true, inclusion: { in: %w[C] }

  before_validation :set_attributes, if: :response_changed?

  def self.average_temperature
    sum(&:average_temperature) / count
  end

  def average_temperature
    (min_temperature + max_temperature) / 2
  end

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
