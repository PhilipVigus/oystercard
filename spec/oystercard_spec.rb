require 'oystercard'

describe Oystercard do
  it 'should have a balance of 0 when it is created' do
    card = Oystercard.new
    expect(card.balance).to eq 0
  end
end