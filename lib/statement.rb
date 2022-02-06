# frozen_string_literal: true

class Statement
  
  attr_reader :balance, :statements
   
  DEFAULT_BALANCE = 0.00
 
  def initialize
    @balance = DEFAULT_BALANCE
    @statements = []
  end
  
  def save_statement(amount, date, status)
    statement = {
      date: date
    }
    if a_debit?(status)
      raise 'Sorry, your balance is insufficient' unless sufficient_funds?(amount)

       @balance -= amount
      statement.merge!(debit: format_string(amount), credit: nil, balance: format_string(@balance))
    else
      @balance += amount
      statement.merge!(debit: nil, credit: format_string(amount), balance: format_string(@balance))
    end
    @statements << statement
  end

  def format_statements
    statements = @statements.dup
    add_header(statements)
    statements.reverse.map do |statement|
      "#{statement[:date]} || #{statement[:credit]} || #{statement[:debit]} || #{statement[:balance]}"
    end
  end

  private

  def sufficient_funds?(amount)
    (@balance - amount) >= DEFAULT_BALANCE
  end

  def format_string(num)
    format('%.2f', num)
  end

  def a_debit?(transaction_type)
    transaction_type == 'debit'
  end

  def add_header(statements)
    statements << {date: 'date', debit: 'debit', credit: 'credit', balance: 'balance'}
  end
end
