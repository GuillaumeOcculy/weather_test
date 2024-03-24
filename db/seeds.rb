user = User.create(email: 'test@example.com', password: 'password', prefered_city: 'paris')
city = City.create(name: 'Paris', accu_weather_key: '623')

forecast = FactoryBot.create(:forecast, city: city)

puts 'Data seeded'
puts "user credentials: email: #{user.email}, password: password"
