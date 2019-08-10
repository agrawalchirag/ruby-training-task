require "./converter.rb"
require "./round_off.rb"

module TaxCalculator
  include Converter, RoundOff
  def self.tax_calculator(price, quantity, salesTax)
    integerPrice = Converter.convert_string_to_number(price)
    integerQuantity = Converter.convert_string_to_number(quantity)
    RoundOff.round_off(integerPrice*integerQuantity*salesTax/100)
  end
end