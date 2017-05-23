require 'order'
require 'voucher'

class User
  attr_accessor :voucher, :orders

  def initialize(orders: [], voucher: nil)
    @voucher = voucher
    @orders = orders
  end

  def create_order
    new_order = Order.new(self)

    new_order.apply_voucher(voucher) if voucher

    @orders << new_order

    new_order
  end
end
