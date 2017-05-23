require 'discount_voucher'
require 'credit_voucher'

class Voucher
  def self.create(type, **attrs)
    case type
    when :discount
      DiscountVoucher.new(
        discount_percentage: attrs.fetch(:amount),
        number_of_uses: attrs.fetch(:number),
        is_instant: attrs.fetch(:instant) { nil }
      )
    else
      CreditVoucher.new(credit: attrs.fetch(:amount))
    end
  end
end
