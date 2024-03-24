class Forecast < ApplicationRecord
  belongs_to :city

  validates :date, presence: true
  validates :response, presence: true

  def min_temperature
    response[0]["Temperature"]["Minimum"]["Value"]
  end

  def max_temperature
    response[0]["Temperature"]["Maximum"]["Value"]
  end
end
