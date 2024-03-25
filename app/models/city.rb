# == Schema Information
#
# Table name: cities
#
#  id               :bigint           not null, primary key
#  accu_weather_key :string           not null
#  name             :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class City < ApplicationRecord
  NAMES = ["london", "new-york", "paris", "seoul", "tokyo"].freeze

  validates :name, presence: true, uniqueness: true, inclusion: { in: NAMES }
  validates :accu_weather_key, presence: true

  before_validation :sanitize_name, if: :name

  private

  def sanitize_name
    self.name = name.strip.downcase
  end
end
