# Good read on using database_cleaner (in lieu of a shared connection):
# - http://devblog.avdi.org/2012/08/31/configuring-database_cleaner-with-rails-rspec-capybara-and-selenium/

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, type: :feature) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do |example|
    begin
      wait_for_ajax if is_js_example?(example)
    rescue Selenium::WebDriver::Error::UnknownError => e
      # ignore "jQuery is not defined" errors. they just mean the page failed to load properly,
      # but we still want to clean the database
      raise unless e.message =~ /jQuery is not defined/
    end
    DatabaseCleaner.clean
  end
end
