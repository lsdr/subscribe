require 'item'

describe Item do

  describe '#new' do
    context 'with valid data' do
      subject(:item) { Item.new(item: 'book', quantity: 3, price: 1.99) }

      it 'is has a designation' do
        expect(item.item).to match('book')
      end

      it 'has a price' do
        expect(item.price).to be(1.99)
      end

      it 'has a quantity' do
        expect(item.quantity).to be(3)
      end

      it 'has a subtotal' do
        expect(item.subtotal).to be(5.97)
      end

      it 'is not imported' do
        expect(item.imported?).to be(false)
      end
    end

    context 'with an imported item' do
      subject(:item) { Item.new(item: 'imported sneakers', quantity: 1, price: 71.99) }

      it 'is imported' do
        expect(item.imported?).to be(true)
      end
    end


  end
end
