class DiscountVoucher
  def initialize(discount_percentage:, number_of_uses:, is_instant: false)
    @times_used = 0
    @number_of_permitted_uses = number_of_uses
    @discount_percentage_as_decimal = discount_percentage / 100.0
    @is_instant = is_instant
  end

  def apply!(base_cost)
    return base_cost if times_used >= number_of_permitted_uses

    @times_used += 1

    discounted_base_cost = base_cost * discount_percentage_as_decimal

    if instant?
      if times_used == 1
        return number_of_permitted_uses * discounted_base_cost
      else
        return 0.0
      end
    end

    discounted_base_cost
  end

  private

  attr_reader :times_used, :discount_percentage_as_decimal, :number_of_permitted_uses, :is_instant

  def instant?
    @is_instant
  end
end
