FactoryBot.define do
  factory :user do
    email { "email@example.com" }
    password_digest { "password" }
    prefered_city { "Paris" }
  end
end
