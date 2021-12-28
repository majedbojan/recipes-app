# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.1'

gem 'pg'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.3', '>= 6.0.3.4'
gem 'turbolinks', '~> 5'
gem 'webpacker'#, '~> 4.0'

gem 'acts_as_api'
gem 'aws-sdk-s3', require: false
gem 'bootsnap', '>= 1.4.2', require: false
gem 'devise'
gem 'image_processing', '~> 1.2'
gem 'jwt'
gem 'pagy'
gem 'phonelib'
gem 'ransack'
gem 'redis', '~> 4.0'
gem 'sidekiq'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry-rails'
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'

  gem 'annotate'
  gem 'letter_opener'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
end

group :test do
  gem 'database_cleaner'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'timecop'
end
