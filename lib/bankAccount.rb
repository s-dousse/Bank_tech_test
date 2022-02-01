require_relative 'statement'

class BankAccount
  DEFAULT_BALANCE = 0.00

  attr_reader :statements

  def initialize()
    @balance = DEFAULT_BALANCE
    @statements = []
  end

  def print_balance
    "The current balance is #{sprintf('%.2f', @balance)}"
  end

  def deposit(amount, date, statement = Statement.new) 
    @balance += amount
    new_statement = statement.save_statement(amount, date, @balance, true)
    @statements.unshift(new_statement)
  end

  def withdraw(amount, date, statement = Statement.new)
    fail "Sorry, your balance is insufficient" unless sufficient_funds?(amount)
    @balance -= amount
    new_statement = statement.save_statement(amount, date, @balance, false)
    @statements.unshift(new_statement)
  end

  def print_statements
    delimiter = " || "
    header = "date || credit || debit || balance"
    list = @statements.map do |statement|
      "#{statement[:date]}" + delimiter + "#{statement[:debit]}"  + delimiter + "#{statement[:credit]}"  + delimiter + "#{statement[:balance]}"
    end
    list.unshift(header)
  end

  private
  def sufficient_funds?(amount)
    (@balance - amount) >= DEFAULT_BALANCE
  end
end