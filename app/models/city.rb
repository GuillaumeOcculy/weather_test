class City < ApplicationRecord
  NAMES = ["London", "New-York", "Paris", "Seoul", "Tokyo"].freeze

  validates :name, presence: true, uniqueness: true, inclusion: { in: NAMES }
  validates :accu_weather_key, presence: true

  before_save :sanitize_name

  private

  def sanitize_name
    self.name = name.strip.downcase
  end
end
