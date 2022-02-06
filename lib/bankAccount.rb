# frozen_string_literal: true

require_relative 'statement'

class BankAccount

  def initialize()
    @statement = Statement.new
  end

  def deposit(amount, date)
    make_transaction(amount, date, 'credit')
  end

  def withdraw(amount, date)
    make_transaction(amount, date, 'debit')
  end

  def print_statements
    puts @statements.format_statements
  end

  private

  def make_transaction(amount, date, status)
    @statement.save_statement(amount, date, status)
  end
end
