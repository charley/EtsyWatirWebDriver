class EtsyItemPage
  include PageMixIn

  attr_accessor :add_to_cart_button, :item_title

  def initialize(browser)
    @browser = browser
    @add_to_cart_button = @browser.button(:value => "Add to Cart")
    @item_title = @browser.div(:id => "item-title")
    super
  end

  def item_title_text
    self.item_title.text
  end

  def click_add_to_cart
    self.add_to_cart_button.click
    EtsyCartPage.new(@browser, false)
  end

end
