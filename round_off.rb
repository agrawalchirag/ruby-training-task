module RoundOff
  def self.round_off(amount)
    (amount*20).ceil/20.00
  end
end