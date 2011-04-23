TEST_DATA_DIR = "./features/support/test_data"

require 'watir-webdriver'
browser = Watir::Browser.new :firefox

Before do
  @browser = browser
end

at_exit do
  browser.close
end