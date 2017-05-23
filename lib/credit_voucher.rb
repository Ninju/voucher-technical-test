class CreditVoucher
  def initialize(**attrs)
    @amount = attrs[:amount]
    @credit_used = 0.0
  end

  def apply!(base_cost)
    remaining_credit_before_application = remaining_credit

    return base_cost if remaining_credit_before_application.zero?

    @credit_used += [base_cost, remaining_credit_before_application].min

    [base_cost - remaining_credit_before_application, 0.0].max
  end

  private

  attr_reader :credit_used, :amount

  def remaining_credit
    [amount - credit_used, 0.0].max
  end
end
