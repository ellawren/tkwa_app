source 'https://rubygems.org'
ruby '2.1.2'

gem 'rails', '3.2.16'

gem 'pg'
gem 'formtastic'
gem 'rails3-jquery-autocomplete'
gem 'ransack'
gem 'jquery-rails'
gem 'paperclip', '~> 3.0' # upload images
gem 'aws-sdk' # amazon web services for storing uploaded images
gem 'simple_calendar', '~> 0.1.9'
gem 'newrelic_rpm'
gem 'nilify_blanks' # to prevent blank contact names, which messes up search results ordering
gem 'sanitize' # used to sanitize notes fields on contacts page
gem 'unicorn' # webserver
gem 'prawn_rails' # pdf generation

group :production do
  gem 'rails_12factor' # prevent Heroku auto-injecting plugins, which causes deprecation error
  gem 'heroku_rails_deflate'
end

group :development, :test do
  gem 'rspec-rails', '2.8.1'
end

group :development do
	gem 'annotate', '~> 2.4.1.beta'
  gem 'bullet' # warn bad code during dev
  gem 'rack-mini-profiler' # speed tests, db queries
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  # gem 'sass-rails',   '3.2.4'
  gem 'coffee-rails', '3.2.2'
  gem 'uglifier', '1.2.3'
  gem 'jquery-ui-rails'
  
  # these two are for coffeescript
  # gem 'therubyracer'
  # gem 'barista'

end


group :test do
  gem 'capybara', '1.1.2'
  gem 'factory_girl_rails', '1.4.0'
end

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.1'

gem 'faker', '1.0.1'
gem 'will_paginate', '3.0.3'

# To use Jbuilder templates for JSON
# gem 'jbuilder'


# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
