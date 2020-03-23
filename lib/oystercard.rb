class Oystercard
  attr_reader :balance
  CARD_LIMIT = 90
  MINIMUM_LIMIT = 1
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail "Balance exceeds #{CARD_LIMIT}" if @balance + amount > CARD_LIMIT
    @balance += amount
  end

  def touch_in
    fail "Card balance below #{Oystercard::MINIMUM_LIMIT}" if @balance < MINIMUM_LIMIT
    @in_journey = true
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  private
  
  def deduct(amount)
    @balance -= amount
  end
end