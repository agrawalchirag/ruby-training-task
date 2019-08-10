require './converter.rb'
require './tax_calculator.rb'
require './round_off.rb'

class Item
  include Converter, TaxCalculator, RoundOff

  def self.get_name(product, imported)
    if imported
      item = product.split()[2]
    else
      item = product.split()[1]
    end
  end

  def self.isImported(product)
    product["imported"]
  end

  def self.total_item_rate(price, quantity, salesTax)
    integerPrice = Converter.convert_string_to_number(price)
    tax = TaxCalculator.tax_calculator(price, quantity, salesTax)
    RoundOff.round_off(tax + integerPrice)
  end

  def self.get_price(product)
    product.split.last
  end

  def self.get_quantity(product)
    product.split.first
  end
end
