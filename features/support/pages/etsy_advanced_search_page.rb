class EtsyAdvancedSearchPage
  include PageMixIn

  attr_accessor :sub_category_select, :search_field, :search_button

  URLS = { :production => "﻿﻿www.etsy.com/search_advanced.php" }

  def initialize(browser, visit = false)
    @browser = browser
    @search_field = @browser.text_field(:id => "search_query")
    @sub_category_select = @browser.div(:class => "search-category").select_list
    @search_button = @browser.div(:id => "advanced-search").button
    @browser.goto URLS[:production] if visit
    super
  end

  def specify_sub_category sub_category
    self.sub_category_select.select sub_category
  end

  def search_for search_term
    self.search_field.set search_term
    self.search_button.click
    EtsySearchResultsPage.new(@browser)
  end
end
