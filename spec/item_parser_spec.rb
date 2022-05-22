require 'item_parser'

describe ItemParser do

  describe '#parse' do
    context 'with valid item' do
      subject { ItemParser.parse('3 imported skates at 27.99') }

      it { is_expected.to contain_exactly({ item: 'imported skates', quantity: 3, price: 27.99 }) }
    end

    context 'with multiple lines' do
      subject { ItemParser.parse("1 book at 1.99\n2 sneakers at 14.78") }

      it { is_expected.to include({ item: 'book', quantity: 1, price: 1.99 }) }
      it { is_expected.to include({ item: 'sneakers', quantity: 2, price: 14.78 }) }
    end


    context 'with invalid text' do
      subject { ItemParser.parse('1 imported bottle of perfume et 27.99') }

      it { is_expected.to be_empty }
    end
  end
end
