require 'discount_voucher'
require 'credit_voucher'

class Voucher
  def self.create(type, **attrs)
    case type
    when :discount
      DiscountVoucher.new(attrs)
    else
      CreditVoucher.new(credit: attrs.fetch(:amount))
    end
  end
end
