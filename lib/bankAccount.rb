# frozen_string_literal: true

require_relative 'statement'

class BankAccount
  DEFAULT_BALANCE = 0.00

  attr_reader :statements

  def initialize
    @balance = DEFAULT_BALANCE
    @statements = []
  end

  def print_balance
    "The current balance is #{format('%.2f', @balance)}"
  end

  def deposit(amount, date)
    @balance += amount
    save_transaction(amount, date, true)
  end

  def withdraw(amount, date)
    raise 'Sorry, your balance is insufficient' unless sufficient_funds?(amount)

    @balance -= amount
    save_transaction(amount, date, false)
  end

  def print_statements
    @statements.map do |statement|
      "#{statement[:date]} || #{statement[:debit]} || #{statement[:credit]} || #{statement[:balance]}"
    end.unshift('date || credit || debit || balance')
  end

  private

  def sufficient_funds?(amount)
    (@balance - amount) >= DEFAULT_BALANCE
  end

  def save_transaction(amount, date, status)
    statement = Statement.new
    statement.save_statement(amount, date, @balance, status)
    @statements.unshift(statement)
  end
end
