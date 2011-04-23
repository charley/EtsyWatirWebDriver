class EtsyCartPage
  include PageMixIn

  URLS = { :production => "﻿www.etsy.com/cart?ref=so_cart" }

  attr_accessor :checkout_header, :remove_link, :first_item_name_link

  def initialize(browser, visit = false)
    @browser = browser
    @checkout_header = @browser.div(:id => "checkout-header")
    @remove_link = @browser.link(:text => "Remove")
    @first_item_name_link = @browser.div(:class => "item-details").link
    @browser.goto URLS[:production] if visit
    super
  end

  def first_item_name_text
    self.first_item_name_link.text
  end

  def items_in_cart
    @checkout_header = @browser.div(:id => "checkout-header") # Needed to avoid stale webdriver error?!?
    self.checkout_header.wait_until_present
    self.checkout_header.text
  end

  def remove_item
    self.remove_link.click
    remove_link.wait_while_present
  end

  def ensure_cart_empty
    100.times do
      self.remove_link.click if items_in_cart != "0 items in your cart"
      break if items_in_cart == "0 items in your cart"
    end
  end
end
