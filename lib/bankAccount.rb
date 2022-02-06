# frozen_string_literal: true

require_relative 'statement'

class BankAccount

  attr_reader :statement

  def initialize()
    @statement = Statement.new
  end

  def deposit(amount)
    make_transaction(amount, 'credit')
  end

  def withdraw(amount)
    make_transaction(amount, 'debit')
  end

  def print_statements
    @statement.format_statements
  end

  private

  def make_transaction(amount, status)
    @statement.save_statement(amount, status)
  end
end
