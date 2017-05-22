class Order
  DEFAULT_PRICE = 6.95

  attr_accessor :user

  def initialize(user)
    @user = user
  end

  def total
    DEFAULT_PRICE
  end
end
