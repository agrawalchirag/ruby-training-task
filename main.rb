require './item.rb'
require './sales_tax.rb'
require './tax_calculator'

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

class Main
  include SalesTax, TaxCalculator

  def get_order(order, exemptedItems)
    puts "-----------------------------Recipent Bill------------------------------------------------"
    totalTax = 0
    totalBill = 0
    order.each do |product|
      imported = Item.isImported(product)
      name = Item.get_name(product, imported)
      price = Item.get_price(product)
      quantity = Item.get_quantity(product)
      salesTax = SalesTax.sales_tax(quantity, price, imported, name, exemptedItems)
      itemRate = Item.total_item_rate(price, quantity, salesTax)      
      totalTax = TaxCalculator.tax_calculator(price, quantity, salesTax) + totalTax
      totalBill = itemRate + totalBill     
      puts "#{name}: #{itemRate}"
    end
    puts "Sales Tax: #{totalTax}"
    puts "Total Bill: #{totalBill}"
  end
end

output = Main.new
output.get_order(Order1, ExemptedItems)
puts "--------------x-------------------x------------------x---------------"

output.get_order(Order2, ExemptedItems)
puts "--------------x-------------------x------------------x---------------"

output.get_order(Order3, ExemptedItems)
puts "--------------x-------------------x------------------x---------------"
