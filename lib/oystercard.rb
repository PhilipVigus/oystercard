class Oystercard
  attr_reader :balance
  CARD_LIMIT = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "Balance exceeds #{CARD_LIMIT}" if @balance + amount >= 90
    @balance += amount
  end
end