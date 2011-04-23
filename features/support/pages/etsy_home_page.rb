class EtsyHomePage
  include PageMixIn

  URLS = { :production => "http://www.etsy.com/" }

  attr_accessor :buy_link

  def initialize(browser, visit = false)
    @browser = browser
    @buy_link = @browser.link(:text => "Buy")
    @browser.goto URLS[:production] if visit
    super
  end

  def click_buy
    self.buy_link.click
    EtsyBuyPage.new(@browser)
  end
end
