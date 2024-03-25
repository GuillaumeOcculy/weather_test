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
FactoryBot.define do
  factory :city do
    name { "Paris" }
    accu_weather_key { "123" }
  end
end
