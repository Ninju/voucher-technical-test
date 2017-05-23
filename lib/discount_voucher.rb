class DiscountVoucher
  def initialize(**attrs)
    @times_used = 0
    @number_of_permitted_uses = attrs.fetch(:number) { Float::INFINITY }
    @discount_rate_as_percentage = attrs.fetch(:amount) / 100.0
  end

  def apply!(base_cost)
    return base_cost if times_used >= number_of_permitted_uses

    @times_used += 1

    base_cost * discount_rate_as_percentage
  end

  private

  attr_reader :times_used, :discount_rate_as_percentage, :number_of_permitted_uses
end
