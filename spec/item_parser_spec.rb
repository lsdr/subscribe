require 'item_parser'

describe ItemParser do

  describe '#parse' do
    context 'with valid item' do
      subject    { ItemParser.parse('3 skates at 27.99') }
      let(:item) { Item.new(quantity: 3, item: 'skates', price: 27.99) }

      it { is_expected.to include(an_object_having_attributes(item: 'skates', price: 27.99, quantity: 3)) }
    end

    context 'with multiple lines' do
      subject { ItemParser.parse("1 book at 1.99\n2 sneakers at 14.78") }

      it { is_expected.to include(an_object_having_attributes(item: 'sneakers', price: 14.78, quantity: 2)) }
      it { is_expected.to include(an_object_having_attributes(item: 'book', price: 1.99, quantity: 1)) }
    end

    context 'with invalid text' do
      subject { ItemParser.parse('1 imported bottle of perfume et 27.99') }

      it { is_expected.to be_empty }
    end
  end
end
