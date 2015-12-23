require "cucumber/rails"
require "json_spec/cucumber"

ActionController::Base.allow_rescue = false

begin
  DatabaseCleaner.strategy = :truncation
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

Cucumber::Rails::Database.javascript_strategy = :truncation

World(FactoryGirl::Syntax::Methods)

def last_json
  page.source
end