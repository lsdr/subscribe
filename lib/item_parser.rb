require 'item'

class ItemParser
  ITEM_FORMAT = /\A(?<quantity>\d+) (?<item>.+) at (?<price>\d+.\d{2})\z/

  def self.parse(items)
    new(items).parse
  end

  def initialize(items = '')
    @items = items.split("\n")
  end

  def parse
    @items.map do |item|
      matched = item.match(ITEM_FORMAT)
      next if matched.nil?

      Item.new(
        item: matched[:item],
        quantity: matched[:quantity].to_i,
        price: matched[:price].to_f
      )
    end.compact
  end
end
