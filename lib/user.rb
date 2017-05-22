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

    @orders << new_order

    new_order
  end
end
