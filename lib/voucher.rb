class Voucher
  attr_accessor :type, :amount, :number, :instant

  def initialize(type, **attrs)
    @type = type
    @amount = attrs[:amount]
    @number = attrs[:number]
    @instant = attrs[:instant]
    @credit_used = 0.0
  end

  def self.create(type, **attrs)
    new(type, **attrs)
  end

  def apply!(base_cost)
    remaining_credit_before_application = remaining_credit

    return base_cost if remaining_credit_before_application.zero?

    @credit_used += [base_cost, remaining_credit_before_application].min

    [base_cost - remaining_credit_before_application, 0.0].max
  end

  def remaining_credit
    [amount - credit_used, 0.0].max
  end

  private

  attr_reader :credit_used
end
