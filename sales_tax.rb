require "./exempted_items.rb"

module SalesTax
  include ItemsExempted

  def self.sales_tax(quantity, price, imported, item, exemptedItems)
    exemptedItem = ItemsExempted.exempted_items(exemptedItems, item)
    if exemptedItem
      ItemsExempted.tax_on_exempted_item(imported)
    elsif imported
      15
    else
      10
    end
  end
end