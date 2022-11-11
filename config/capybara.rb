# frozen_string_literal: true

Capybara.register_driver :selenium do |app|
  capabilities = Selenium::WebDriver::Chrome::Options.new(
    args: %w[--window-size=1400,1400]
  )
  Capybara::Selenium::Driver.new(app, browser: :chrome, capabilities:)
end

Capybara.javascript_driver = :chrome

Capybara.configure do |config|
  config.default_max_wait_time = 10
  config.default_driver = :selenium
end
