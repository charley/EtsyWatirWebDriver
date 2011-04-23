Given /^I am searching on Etsy\.com$/ do
  @advanced_search_page = EtsyAdvancedSearchPage.new(@browser, true)
  @advanced_search_page.title.should == "Etsy :: Advanced Search"
end

Given /^I am on Etsy\.com$/ do
  @etsy_home_page = EtsyHomePage.new(@browser, true)
  @etsy_home_page.title.should == "Etsy - Your place to buy and sell all things handmade, vintage, and supplies"
end

Given /^I am on the Etsy cart page$/ do
  @etsy_cart_page = EtsyCartPage.new(@browser, true)
end

Given /^that the cart is empty$/ do
  @etsy_cart_page.ensure_cart_empty
  @etsy_cart_page.items_in_cart.should == "0 items in your cart"
end

When /^I specify the (.+) sub category$/ do |sub_category|
  @advanced_search_page.specify_sub_category sub_category
end

When /^I search for '(.+)'$/ do |search_term|
  @search_results_page = @advanced_search_page.search_for search_term
end

When /^I want to browse through a treasury gallery$/ do
  @etsy_buy_page = @etsy_home_page.click_buy
  @etsy_buy_page.title.should == "Etsy - Buy"
  @etsy_treasury_page = @etsy_buy_page.click_treasury_button
  @etsy_treasury_page.title.should == "Etsy - Treasury"
end

When /^an item is added to the cart$/ do
  @advanced_search_page = EtsyAdvancedSearchPage.new(@browser, true)
  @search_results_page = @advanced_search_page.search_for "hat"
  @etsy_item_page = @search_results_page.click_first_result
  @item_title = @etsy_item_page.item_title_text
  @etsy_cart_page = @etsy_item_page.click_add_to_cart
end

Then /^I should see some search results for '(.+)'$/ do |search_term|
  @search_results_page.search_results_text.should =~ /\d+,?\d* results for #{search_term}/
  @search_results_page.search_results_text.should_not =~ /We didn't find anything for #{search_term}\./
end

Then /^I should see no search results for '(.+)'$/ do |search_term|
  @search_results_page.search_results_text.should =~ /We didn't find anything for #{search_term}\./
  @search_results_page.search_results_text.should_not =~ /\d+,?\d* results for #{search_term}/
end

Then /^I should see that the search was for '(.+)' instead of '(.+)'$/ do |new_search_term, search_term|
  @search_results_page.spelling_text.should == "No results found for #{search_term}, searching instead for #{new_search_term}."
end

Then /^results will be displayed in the gallery$/ do
  @etsy_treasury_page.list_treasury.exists?.should be_true
  @etsy_treasury_page.item_treasury.exists?.should be_true
  @etsy_treasury_page.item_hotness.exists?.should be_true
  @etsy_treasury_page.item_info.exists?.should be_true
  @etsy_treasury_page.item_stats.exists?.should be_true
  @etsy_treasury_page.item_preview.exists?.should be_true
end

Then /^the cart contains that item$/ do
  @etsy_cart_page.items_in_cart.should == "1 item in your cart"
  @etsy_cart_page.first_item_name_text.should == @item_title
end

When /^I remove the item from the cart$/ do
  @etsy_cart_page.remove_item
end

Then /^the cart is empty$/ do
  @etsy_cart_page.items_in_cart.should == "0 items in your cart"
end

