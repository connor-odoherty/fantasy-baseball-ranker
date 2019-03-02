# frozen_string_literal: true

source 'https://rubygems.org'
ruby '2.5.3'
gem 'dotenv-rails', groups: %i[development test], require: 'dotenv/rails-now'

gem 'autoprefixer-rails', '~> 6.7'

gem 'rails', '~> 5.0.7'

gem 'sprockets', '~> 3.7.2'

# Force upgrade for CVE-2018-1000119
gem 'rack-protection', '~> 1.5.5'

# Use pg as the database for Active Record
gem 'pg', '~>0.21.0'
# Bulk activerecord load, used in fuel sheet import.
gem 'activerecord-import', '~>0.21.0'
# POSTGIS is goelocation search
gem 'activerecord-postgis-adapter', '~> 4.0' # 4.x supports activerecord 5.0+ 5.x supports 5.1+ rails 5
# Define triggers in migrations
gem 'hairtrigger', '~> 0.2.21'
# versioned views with migrations
gem 'scenic', '~> 1.4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.0'
# Bootstrap
gem 'bootstrap-sass', '~> 3.3.6'

# Use Uglifier as compressor for JavaScript assets
# Set to 3.2 for now since the 'copyright' flag in 4.0 has a problem with sprockets
# Once sprockets updates we can update to 4.0 and beyond
gem 'uglifier', '~> 3.2.0'

gem 'therubyracer', platforms: :ruby, group: %i[production development test]
# Enable respond_to / respond_with
gem 'responders', '~> 2.0'

# Use jquery as the JavaScript library
gem 'jquery-rails', '~>4.3.1'
gem 'jquery-ui-rails', '~>5.0.5'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks', git: 'https://github.com/turbolinks/turbolinks-classic.git', :branch => 'master'
gem 'turbolinks', '~> 5.1.1'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.0'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'net-ftp-list', '~> 3.2.9'
# this gem allows for automatic JS code to add/remove nested form elements
# we use this in the calendar to add multiple crew to an event
# use this when you have a has_many and want to edit them all
gem 'nested_form_fields', '~> 0.8.1'

gem 'newrelic_rpm', '~> 4.2.0'

# Use puma as the app server
gem 'puma', '~> 3.11.0'

gem 'attr_encrypted', '~> 3.0.0'
gem 'bundler-audit', '~> 0.6.0'
gem 'jsonapi-serializers', '~> 1.0.0'

gem 'slim-rails', '~> 3.1.2'

gem 'browser', '~>2.4.0'

group :development do
  gem 'annotate'
  gem 'web-console', '~> 3.6'

  # gem 'better_errors'
  gem 'binding_of_caller'

  gem 'meta_request'

  gem 'bullet'
  gem 'launchy'
  gem 'railroady'
  gem 'resque-backtrace', require: false, platforms: :ruby

  gem 'oink', '~> 0.10.1'
end

group :test do
  gem 'database_cleaner'

  gem 'm', '~> 1.5.0'
  gem 'minitest'
  gem 'minitest-fail-fast'
  gem 'minitest-profile'
  gem 'minitest-rails', '~> 3.0' # upgrade to 3.0 for rails 5, must be done at same time
  gem 'minitest-rails-capybara', '~> 3.0' # upgrade to 3.0 for rails 5
  gem 'minitest-reporters'

  gem 'rails-controller-testing'

  # gem 'stripe-ruby-mock', '~>2.2.0', require: 'stripe_mock'

  gem 'poltergeist'
end

group :development, :test do
  gem 'derailed'
  gem 'derailed_benchmarks'
  gem 'factory_bot_rails'
  gem 'guard'
  gem 'guard-minitest'
  gem 'knapsack'
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'quality', '~> 20.1.0'
  gem 'reek'
  gem 'rubocop'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'ruby-prof'
  gem 'spring', '~> 1.6.0'
  # gem 'letter_opener'
end

# make application load faster
gem 'bootsnap', require: false

# ach verification
gem 'plaid', '~>4.0'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw]

# needed for windows to function now
gem 'sys-proctable', platforms: %i[mingw mswin x64_mingw]

# Enable Heroku platform features
group :production do
  gem 'flamegraph', '~> 0.9.5'
  gem 'rack-timeout', '~> 0.4.2'
  gem 'rails_12factor', '~> 0.0.3'
  gem 'resque-slack', git: 'https://github.com/TSwimson/resque-slack.git'
end

# Core functionality
gem 'audited', '~> 4.7.0'

gem 'RubySunrise', '~> 0.3.1'

gem 'deep_cloneable', '~>2.2.1'
gem 'devise', '~> 4.4.0'

gem 'friendly_id', '~> 5.2.0'

gem 'paperclip', '~> 5.2.0'
# used to add multiple photos in one download
gem 'rubyzip', '~> 1.2.1'

gem 'rails-jquery-autocomplete'

# Profiling
gem 'memory_profiler', '~>0.9.8'
gem 'rack-mini-profiler', '~>0.10.5'

gem 'stackprof', '~>0.2.10', platforms: :ruby

# slack-api
gem 'slack-ruby-client', group: :production

# Redis / Resque
platform :ruby do
  gem 'active_scheduler', '~>0.5.0'
  gem 'redis', '~> 4.0.0'
  gem 'redis-rails', '~>5.0.2'
  gem 'resque', '~> 1.27.0'
  gem 'resque-scheduler', '~> 4.3.0'
end

gem 'administrate', '~>0.10.0'
gem 'administrate-field-belongs_to_search', '~>0.4.0'
gem 'administrate-field-paperclip'
gem 'jbuilder', '~> 2.0' # seems to be only used for administrate gem

# Calendaring
# fullcallendar is currently included in assets since the gem has not been updated to the latest yet
# gem 'fullcalendar-rails', '~> 3.2.0.0'

gem 'bootstrap-datepicker-rails', require: 'bootstrap-datepicker-rails', git: 'https://github.com/TSwimson/bootstrap-datepicker-rails.git'
gem 'jquery-timepicker-rails', '1.11.4'
gem 'momentjs-rails', '~> 2.11.0'

# time validation
gem 'validates_timeliness', '~> 4.0'

# GCal sync
gem 'google-api-client', '~>0.22'
gem 'omniauth', '~> 1.4.1'
gem 'omniauth-google-oauth2', '~> 0.5.1'

# 2 factor
# gem 'devise_google_authenticator', '~> 0.3.16'
gem 'devise_google_authenticator', git: 'https://github.com/montulli/devise_google_authenticator.git'

# JWT JSON Web Token support with Devise integration
gem 'devise-jwt', '~> 0.4.0'

# SAML IDP integration  Allow other sites and apps to authenicate users through our username/password system
gem 'saml_idp', '~> 0.7.2'

# google recaptcha
gem 'recaptcha', '~> 4.3.1'

# Quickbooks sync
gem 'quickbooks-ruby', '~> 0.4.3'
gem 'riif', '~> 0.7.0'

# CORS
gem 'rack-cors', '~> 1.0.1', require: 'rack/cors'

# Javascript
gem 'data-confirm-modal', git: 'https://github.com/ifad/data-confirm-modal.git'

# Role base authorization
gem 'pundit', '~> 1.1.0'
gem 'role_model', '~> 0.8.2'

# test data generator
gem 'faker', '=1.7.3'

gem 's3_direct_upload', '~> 0.1.7'

# pdf generation
# gem 'shrimp', '~> 0.0.6'
gem 'shrimp', git: 'https://github.com/montulli/shrimp.git' # git: 'https://github.com/TSwimson/shrimp.git' #

# add data to existing PDF form
gem 'pdf-forms', '~> 1.0.0'

# route boxer for use with google maps.  Used for fuel stop search
gem 'route_boxer', '~> 0.0.2'

# sending sms notifications
gem 'perfect-scrollbar-rails', '~>0.6.15'
gem 'twilio-ruby', '~> 5.6.0'

# weather
gem 'forecast_io', '~>2.0.2'

# used in avinode email parsing to format address
gem 'geocoder', '~>1.4.4'

# handle database uniq constraint validations and turns them into freindly active record errors
gem 'rescue_unique_constraint', '~> 1.4.0'

# parse URI and edit params.  Used for URL generation and for datatables filter saving
gem 'uri-js-rails', '~>1.15.2'

# gem 'activerecord-tablefree', '~> 3.0'

gem 'pdf-reader', '~>2.0.0'

# eAPIS gems

# used to test bitmasking for Aircraft amenities, should be removed later after reverse engineering to use RoleModel
gem 'bitmask_attributes'

# graphing stuff
gem 'c3-rails', '~> 0.4.11'
gem 'd3-rails', '~> 3.5.17'

# accesses Google places data, used to lookup locations by saved location ID
gem 'google_places', '~>0.34.2'

gem 'handlebars_assets'

# ranker toolset
gem 'ranked-model'

# calculates ELO ranking
gem 'elo_rating'

gem 'bcrypt', '3.1.12'

# lets us drag and drop items in a list
gem 'acts_as_list'

gem 'font-awesome-rails'

gem 'smarter_csv'

gem 'scout_apm'