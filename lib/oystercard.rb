class Oystercard
  attr_reader :balance
  CARD_LIMIT = 90
  MINIMUM_LIMIT = 1

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail "Balance exceeds #{CARD_LIMIT}" if @balance + amount > 90
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    fail "Card balance below #{Oystercard::MINIMUM_LIMIT}" if @balance < 1
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end
end