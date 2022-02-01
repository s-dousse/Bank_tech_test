# frozen_string_literal: true

require 'bankAccount'

# check full feature test (irb) in README.md
describe BankAccount do
  context 'basic user journey' do
    account = BankAccount.new

    it 'Given a client makes a deposit of 1000 on 10-01-2023' do
      account.deposit(1000.00, '10-01-2023')
      expect(account.print_balance).to include '1000.00'
    end

    it 'And a deposit of 2000 on 13-01-2023' do
      account.deposit(2000.00, '13-01-2023')
      expect(account.print_balance).to include '3000.00'
    end

    it 'And a withdrawal of 500 on 14-01-2023' do
      account.withdraw(500.00, '14-01-2023')
      expect(account.print_balance).to include '2500.00'
    end
  end
end
