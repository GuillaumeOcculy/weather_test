# README

Weather Test App

Things you may want to cover:

* Ruby version 3.3.0

* Rails version 7.0.8

* Postgresql

* Bootstrap

* [API local Documentation](http://localhost:3000/api-docs)

* [API staging Documentation](https://weather-test-610662844f1c.herokuapp.com/api-docs)

* You can run: `rspec spec` 

* Database initialization : `rails db:setup`

* User credentials : `text@example.com` / `password`

* Because of Accu Weather API limitations (50 calls / day), I save responses so I'm not making the same request twice.

* You need to add your `ACCU_WEATHER_API_KEY` within `.env` file. You need to register on [https://developer.accuweather.com/apis](https://developer.accuweather.com/apis) then follow the instructions. You need to ask for a `Core Weather Limited Trial` product.

* Run `rails server` and go to [localhost:3000](http://localhost:3000)

* You can try on [Staging](https://weather-test-610662844f1c.herokuapp.com/)

* Rack Attack: On Staging, you can only make 5 calls per 10 seconds
