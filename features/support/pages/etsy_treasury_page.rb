class EtsyTreasuryPage
  include PageMixIn

  attr_accessor :list_treasury, :item_treasury, :item_hotness, :item_info, :item_stats, :item_preview

  def initialize(browser)
    @browser = browser
    @list_treasury = @browser.div(:class => "list-treasury")
    @item_treasury = @list_treasury.li(:class => "item-treasury")
    @item_hotness = @item_treasury.div(:class => "item-treasury-hotness")
    @item_info = @item_treasury.div(:class => "item-treasury-info")
    @item_stats = @item_treasury.div(:class => "item-treasury-stats")
    @item_preview = @item_treasury.div(:class => "item-treasury-preview")
    super
  end

end