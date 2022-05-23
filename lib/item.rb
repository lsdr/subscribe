class Item

  attr_reader :item, :quantity, :price

  def initialize(item:, quantity:, price:)
    @item = item
    @quantity = quantity
    @price = price
  end

  def subtotal
    @subtotal ||= price * quantity
  end

  def imported?
    @item.match?(/imported/)
  end
end
