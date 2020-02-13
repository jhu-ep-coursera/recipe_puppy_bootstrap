require 'rspec'
require 'capybara'
require 'capybara/dsl'
require 'webdrivers'
require 'selenium/webdriver'

RSpec.configure do |config|
  config.include Capybara::DSL
end

Capybara.default_driver = :selenium_chrome_headless
Capybara.javascript_driver = :selenium_chrome_headless

# If you want to see the tests actually running in the Chrome browser
# uncomment the lines below and comment out the above 2 lines

# Capybara.default_driver = :selenium_chrome
# Capybara.javascript_driver = :selenium_chrome

# Slows down the execution speed of the tests
# Source - https://stackoverflow.com/a/46840590/908842
# module ::Selenium::WebDriver::Remote
#   class Bridge
#     alias_method :old_execute, :execute
#     def execute(*args)
#       sleep(0.5)
#       old_execute(*args)
#     end
#   end
# end