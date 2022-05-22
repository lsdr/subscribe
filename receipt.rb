#!/usr/bin/env ruby
#
# input parsing
ITEM_FORMAT = /\A(?<quantity>\d+) (?<item>.+) at (?<price>\d+.\d{2})\z/

# tax and duty rules
SALEX_TX = 0.1
IMPORT_DUTY = 0.05

SALES_TX_EXEMPTIONS = [
  'book', 'chocolate', 'pill'
]

if ARGV.empty?
  puts 'Usage: receipt.rb <input_file>'
  exit
end

# puts ARGV.inspect
ARGV.each do |file_name|
  file = File.open(file_name)

  items = file.readlines.map do |line|
    line.chomp!
    match = line.match(ITEM_FORMAT)

    {
      item: match[:item],
      quantity: match[:quantity].to_i,
      price: match[:price].to_f
    }
  end

  # puts items.inspect

  items.map! do |item|
    subtotal = item[:price] * item[:quantity]
    tax = 0.0

    tax += (subtotal * SALEX_TX) unless SALES_TX_EXEMPTIONS.any? { |exp| item[:item].match?(exp) }
    tax += (subtotal * IMPORT_DUTY) if item[:item].match?(/imported/)

    tax = tax.round(2)
    total_price = (tax + subtotal).round(2)

    item.merge(subtotal:, tax:, total_price:)
  end

  # puts(items.inspect)
  
  puts("-"*80)
  items.each do |item|
    puts "%<quantity>d %<item>s: %<total_price>.2f" % item
  end
  puts 'Sales Taxes: %.2f' % items.sum {|i| i[:tax]}
  puts 'Total: %.2f' % items.sum {|i| i[:total_price]}
end
