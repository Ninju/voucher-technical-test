class Order
  DEFAULT_PRICE = 6.95

  attr_accessor :user

  def initialize(user)
    @user = user
    @applied_voucher = nil
  end

  def total
    @total ||= if applied_voucher
                 applied_voucher.apply!(DEFAULT_PRICE)
               else
                 DEFAULT_PRICE
               end
  end

  def apply_voucher(voucher)
    # because it mutates the underlying voucher, we allow only 1 voucher to be
    # applied to a particular order
    return if applied_voucher
    @applied_voucher = voucher
    reset_cached_totals
  end

  private

  attr_reader :applied_voucher

  def reset_cached_totals
    @total = nil
  end
end
