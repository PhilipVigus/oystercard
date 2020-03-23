require 'oystercard'

describe Oystercard do
  it 'should have a balance of 0 when it is created' do
    expect(subject.balance).to eq 0
  end

  it 'allows you to top it up' do
    expect(subject).to respond_to(:top_up).with(1).argument  
  end

  it 'should top up a card' do
    expect { subject.top_up 20 }.to change { subject.balance }.by 20
  end

  it 'should not allow balance to be over £90' do
    expect { subject.top_up(100) }.to raise_error "Balance exceeds #{Oystercard::CARD_LIMIT}"
  end

  it 'should allow you to deduct money' do
    expect(subject).to respond_to(:deduct).with(1).argument
  end

  it 'should deduct a given amount from balance' do
    subject.top_up(20)
    expect { subject.deduct 10 }.to change { subject.balance }.by -10
  end
end