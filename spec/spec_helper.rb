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