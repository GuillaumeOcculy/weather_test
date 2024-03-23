class City < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :accu_weather_key, presence: true

  before_save :sanitize_name

  private

  def sanitize_name
    self.name = name.strip.downcase
  end
end
