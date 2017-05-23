class DiscountVoucher
  def initialize(**attrs)
    @times_used = 0
    @number_of_permitted_uses = attrs.fetch(:number) { Float::INFINITY }
    @discount_rate_as_percentage = attrs.fetch(:amount) / 100.0
    @is_instant = attrs.fetch(:instant) { false }
  end

  def apply!(base_cost)
    return base_cost if times_used >= number_of_permitted_uses

    @times_used += 1

    discounted_base_cost = base_cost * discount_rate_as_percentage

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

  attr_reader :times_used, :discount_rate_as_percentage, :number_of_permitted_uses, :is_instant

  def instant?
    @is_instant
  end
end
