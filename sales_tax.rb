require "pry"
require_relative "converter.rb"

Order1 = [
  '1 book at 12.49', 
  '1 music CD at 14.99', 
  '1 chocolate bar at 0.85'
]

Order2 = [
  '1 imported box of chocolates at 10.00',
  '1 imported bottle of perfume at 47.50'
]

Order3 = [
  "1 imported bottle of perfume at 27.99",
  "1 perfume at 18.99",
  "1 pills at 9.75",
  "1 imported chocolates at 11.25"
]

ExemptedItems = [
  "book", 
  "chocolate", 
  "box"
]

class SalesTaxCalculator
  include Converter

  def get_order_details(order1, exemptedItems)
    puts "Output ---------------------------->"
    totalTax = 0
    totalBill = 0
    order1.each do |product|
      quantity = get_quantity(product)
      price = get_price(product)
      imported = isImported(product)
      item = get_item(product, imported)
      salesTax = sales_tax(quantity, price, imported, item, exemptedItems)
      itemRate = total_item_rate(price, quantity, salesTax)
      totalTax = tax_calculator(price, quantity, salesTax) + totalTax
      totalBill = itemRate + totalBill
      puts "#{item}: #{itemRate}"
    end
    puts "Sales Tax: #{totalTax}"
    puts "Total Bill: #{totalBill}"
  end

  def total_item_rate(price, quantity, salesTax)
    integerPrice = Converter.convert_string_to_number(price)
    tax = tax_calculator(price, quantity, salesTax)
    tax + integerPrice
  end

  def tax_calculator(price, quantity, salesTax)
    integerPrice = Converter.convert_string_to_number(price)
    integerQuantity = Converter.convert_string_to_number(quantity)
    integerPrice*integerQuantity*salesTax/100
  end

  def sales_tax(quantity, price, imported, item, exemptedItems)
    exemptedItem = exempted_items(exemptedItems, item)
    if exemptedItem
      tax_on_exempted_item(imported)
    elsif imported
      15
    else
      10
    end
  end

  def tax_on_exempted_item(imported)
    if imported
      5
    else
      0
    end
  end

  def exempted_items(exemptedItems, item)
    exemptedItems.include?(item)
  end

  def get_quantity(product)
    product.split.first
  end

  def get_price(product)
    product.split.last
  end

  def isImported(product)
    product["imported"]
  end

  def get_item(product, imported)
    if imported
      item = product.split()[2]
    else
      item = product.split()[1]
    end
  end
end

output = SalesTaxCalculator.new
output.get_order_details(Order1, ExemptedItems)
puts "---------------------------------------------------------------"

output.get_order_details(Order2, ExemptedItems)
puts "---------------------------------------------------------------"

output.get_order_details(Order3, ExemptedItems)
