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
FactoryBot.define do
  factory :forecast do
    city
    date { Date.today }
    response { { "Date" => "2021-07-01T07:00:00+02:00", "Temperature" => { "Minimum" => { "Value" => 5, "Unit" => "C"}, "Maximum" => { "Value" => 15, "Unit" => "C"}} } }
  end
end
