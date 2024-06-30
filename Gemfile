source "https://rubygems.org"

ruby "3.0.2"
gem "bcrypt", "~> 3.1.7"
gem "bootsnap", require: false
gem 'dotenv-rails', groups: [:development, :test] #used for loading data from .env file
gem "importmap-rails"
gem "jbuilder" #keeping this for APIs 
gem 'pg'
gem "puma", ">= 5.0"
gem "rails", "~> 7.1.3", ">= 7.1.3.4"
gem "sprockets-rails"
gem "tailwindcss-rails", "~> 2.6" 
gem "tzinfo-data", platforms: %i[ mswin mswin64 mingw x64_mingw jruby ]
group :development, :test do
  gem "debug", platforms: %i[ mri mswin mswin64 mingw x64_mingw ]
end
group :development do
  gem 'pry', '~> 0.14.2'
  gem "web-console"
end
group :test do
  gem "capybara"
  gem "selenium-webdriver"
end