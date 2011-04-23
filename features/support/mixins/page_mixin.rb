module PageMixIn
  attr_accessor :search_field

  def initialize *args, &block
  end

  def method_missing sym, *args, &block
    @browser.send sym, *args, &block
  end
end