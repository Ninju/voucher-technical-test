require 'spec_helper'

describe "Integration" do
  let(:user) { User.new(voucher: voucher) }

  context 'no voucher' do
    let(:voucher) { nil }

    it 'should bill default price all the time' do
      3.times do
        order = user.create_order
        expect(order.total).to eql 6.95
      end
    end
  end

  context 'vouchers' do
    describe 'default vouchers' do
      let(:voucher) { Voucher.create(:credit, amount: 15) }

      it 'should not bill user if has a remaining credit' do
        user.create_order
        expect(user.orders[0].total).to eql 0.0
        user.create_order
        expect(user.orders[1].total).to eql 0.0
        user.create_order
        expect(user.orders[2].total).to eql 5.85
      end
    end

    describe 'discount vouchers' do
      context 'pay as you go' do
        let(:voucher) { Voucher.create(:discount, amount: 50, number: 3) }

        it 'should bill the right amount' do
          user.create_order
          expect(user.orders[0].total).to eql 3.475
          user.create_order
          expect(user.orders[1].total).to eql 3.475
          user.create_order
          expect(user.orders[2].total).to eql 3.475
          user.create_order
          expect(user.orders[3].total).to eql 6.95
        end
      end

      context 'pay with first order' do
        let(:voucher) { Voucher.create(:discount, amount: 50, number: 3, instant: true) }

        it 'should pay 3 bags instantly and charge forth normally' do
          user.create_order
          expect(user.orders[0].total).to eql 10.425
          user.create_order
          expect(user.orders[1].total).to eql 0.0
          user.create_order
          expect(user.orders[2].total).to eql 0.0
          user.create_order
          expect(user.orders[3].total).to eql 6.95
        end
      end
    end
  end
end
