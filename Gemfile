source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.2"

gem 'ed25519', '>= 1.2', '< 2.0'
gem 'bcrypt_pbkdf', '>= 1.0', '< 2.0'
gem 'image_processing', '>= 1.2'
gem 'dotenv-rails'
gem 'active_storage_validations'
gem 'mailjet'
gem 'aws-sdk-s3'
gem 'bootsnap', require: false
gem 'carrierwave', '~> 2.0'
gem 'devise'
gem 'devise-i18n'
gem 'devise-bootstrapped'
gem 'fog-aws'
gem 'jbuilder'
gem 'jsbundling-rails'
gem 'cssbundling-rails'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.2', '>= 7.0.2.4'
gem 'rails-i18n', '~> 7.0.0'
gem 'rmagick'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails', '~> 1.0'
gem 'tzinfo-data', platforms: %i[ mingw mswin x64_mingw jruby ]

group :development, :test do
  gem 'debug', platforms: %i[ mri mingw x64_mingw ]
  gem 'sqlite3', '~> 1.4'
  gem 'letter_opener'
end

group :development do
  gem 'web-console'
  gem 'capistrano', '~> 3.10', require: false
  gem 'capistrano-bundler', '~> 2.0'
  gem 'capistrano-passenger'
  gem 'capistrano-rails', '~> 1.3', require: false
  gem 'capistrano-rvm'
end

group :production do
  gem 'pg'
end
