source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.3.0"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.8", ">= 7.0.8.1"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

gem 'rack-mini-profiler', "~> 3.3.1" # Profiler for your development and production Ruby rack apps

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem "bcrypt", "~> 3.1.7"
gem "jwt", "~> 2.8" # A pure ruby implementation of the RFC 7519 OAuth JSON Web Token (JWT) standard

gem 'bootstrap', '~> 5.3.2' # Bootstrap is a front-end framework for developing responsive, mobile first projects on the web.
gem 'dartsass-sprockets', '~> 3.1.0' # Dart Sass adapter for the Rails asset pipeline

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

gem "httparty", "~> 0.21" # Makes http fun! Also, makes consuming restful web services dead easy.
gem 'rack-attack' # Middleware for blocking & throttling abusive requests


gem 'rswag-api', '~> 2.13' # Swagger for Rails API's
gem 'rswag-ui', '~> 2.13' # Swagger UI for Rails API's
group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "dotenv-rails"
  gem "pry-byebug"
  gem 'rspec-rails', '~> 6.1.0'
  gem 'rswag-specs', '~> 2.13'
  gem "factory_bot_rails"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
  gem 'bullet', '~> 7.1' # help to kill N+1 queries and unused eager loading
  gem 'annotate', '~> 3.2' # Annotate Rails classes with schema information
  gem 'brakeman', '~> 6.1' # Security scanner for Ruby on Rails applications
  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem "webmock" # Library for stubbing and setting expectations on HTTP requests in Ruby
  gem 'shoulda-matchers', '~> 6.0' # Provides RSpec-compatible one-liners to test common Rails functionality
end
