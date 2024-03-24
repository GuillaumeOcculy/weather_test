FactoryBot.define do
  factory :forecast do
    city
    date { Date.today }
    response { { "Date" => "2021-07-01T07:00:00+02:00", "Temperature" => { "Minimum" => { "Value" => 5, "Unit" => "C"}, "Maximum" => { "Value" => 15, "Unit" => "C"}} } }
  end
end
