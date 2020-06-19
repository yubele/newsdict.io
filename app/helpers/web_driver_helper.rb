module WebDriverHelper
  # Get source
  # @param [String] url
  # @param [Integer] delay
  def get_source(url, delay=nil)
    Selenium::WebDriver.logger.output = File.join("./log", "selenium.log")
    Selenium::WebDriver.logger.level = :info
    options = Selenium::WebDriver::Chrome::Options.new(args: [
      'headless',
      'no-sandbox',
      'disable-gpu'
      ])
    driver = Selenium::WebDriver.for(:chrome, options: options)
    driver.manage.timeouts.implicit_wait = 10
    Selenium::WebDriver::Wait.new(timeout: 10)
    driver.get(url)
    if delay.is_a?(Integer)
      sleep delay
    end
    source = driver.page_source
    driver.quit
    source
  end
  module_function :get_source
end