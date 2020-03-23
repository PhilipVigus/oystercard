require 'oystercard'

describe Oystercard do
  it 'should have a balance of 0 when it is created' do
    expect(subject.balance).to eq 0
  end

  context '#top_up' do
    it 'allows you to top it up' do
      expect(subject).to respond_to(:top_up).with(1).argument  
    end

    it 'should top up a card' do
      expect { subject.top_up 20 }.to change { subject.balance }.by 20
    end

    context 'card already topped up' do
      before do
        subject.top_up(Oystercard::CARD_LIMIT)
      end

      it 'should not allow balance to be over £90' do
        expect { subject.top_up(1) }.to raise_error "Balance exceeds #{Oystercard::CARD_LIMIT}"
      end
    end
  end

  context 'in journey' do
        
    it 'can be touched in' do
      expect(subject).to respond_to :touch_in
    end

    it 'can be touched out' do
      expect(subject).to respond_to :touch_out
    end

    it 'starts as being touched out' do
      expect(subject).not_to be_in_journey
    end

    context 'requires initial balance > 1 and touch_in' do
      before do
        subject.top_up(5)
        subject.touch_in
      end 

      it 'correctly tells you if it is in a journey' do
        expect(subject).to be_in_journey
      end

      it 'correctly tells you if it is not in a journey' do
        subject.touch_out
        expect(subject).not_to be_in_journey
      end

      it 'deducts the minimum fare when you touch out' do
        expect { subject.touch_out }.to change { subject.balance }.by -Oystercard::MINIMUM_FARE
      end
    end

    it 'prevents journey if card below minimum balance' do
      expect { subject.touch_in }.to raise_error "Card balance below #{Oystercard::MINIMUM_LIMIT}"
    end
  end
end