module ItemsExempted
  def self.exempted_items(exemptedItems, item)
    exemptedItems.include?(item)
  end

  def self.tax_on_exempted_item(imported)
    if imported
      5
    else
      0
    end
  end
end