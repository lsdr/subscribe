#!/usr/bin/env ruby
#
$:.unshift("#{Dir.pwd}/lib")

require 'item_parser'

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
  items = ItemParser.parse(file.read)

  # puts items.inspect

  items.map! do |item|
    tax = 0.0

    tax += (item.subtotal * SALEX_TX) unless SALES_TX_EXEMPTIONS.any? { |exp| item.item.match?(exp) }
    tax += (item.subtotal * IMPORT_DUTY) if item.imported?

    tax = tax.round(2)
    total_price = (tax + item.subtotal).round(2)

    item.merge(subtotal:, tax:, total_price:)
  end

  puts("-"*80)
  items.each do |item|
    puts "%<quantity>d %<item>s: %<total_price>.2f" % item
  end
  puts 'Sales Taxes: %.2f' % items.sum {|i| i[:tax]}
  puts 'Total: %.2f' % items.sum {|i| i[:total_price]}
end
