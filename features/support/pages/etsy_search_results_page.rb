class EtsySearchResultsPage
  include PageMixIn

  attr_accessor :search_results, :spelling, :first_result_link

  def initialize(browser)
    @browser = browser
    @search_results = @browser.h1(:class => "summary")
    @spelling = @browser.p(:class => "spelling")
    @first_result_link = @browser.link(:class => "listing-thumb")
    super
  end

  def search_results_text
    self.search_results.text
  end

  def spelling_text
    self.spelling.text
  end

  def click_first_result
    self.first_result_link.click
    EtsyItemPage.new(@browser)
  end

end
