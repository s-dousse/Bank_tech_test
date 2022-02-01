# frozen_string_literal: true

require 'bankAccount'

class Statement
  def save_statement(amount, date, balance, status)
    statement = {
      date: date,
      balance: format_string(balance)
    }
    if a_debit?(status)
      statement.merge!(debit: format_string(amount), credit: '-')
    else
      statement.merge!(debit: '-', credit: format_string(amount))
    end
    statement
  end

  private

  def format_string(num)
    format('%.2f', num)
  end

  def a_debit?(status)
    status == true
  end
end
