# frozen_string_literal: true

class Payment < ApplicationRecord
  belongs_to :loan
  before_create :payment_date

  #method is from README
  def outstanding_balance
    loan.funded_amount - loan.payments.amount
  end

  def payment_date
    Time.now
  end

  def amount_greater_than_loan?
    errors.add(:amount, 'Your payment amount exceeds the outstanding balance of the loan and cannot be created.')
    if amount > outstanding_balance
    end
  end
end