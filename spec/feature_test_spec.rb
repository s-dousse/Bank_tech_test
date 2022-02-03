# frozen_string_literal: true

require 'bankAccount'

# check full feature test (irb) in README.md
describe BankAccount do
  context 'basic user journey' do
    account = BankAccount.new

    it 'Given a client makes a deposit of 1000 on 10-01-2023' do
      account.deposit(1000.00, '10-01-2023')
      expect(account.print_balance).to eq('The current balance is 1000.00')
    end

    it 'And a deposit of 2000 on 13-01-2023' do
      account.deposit(2000.00, '13-01-2023')
      expect(account.print_balance).to eq('The current balance is 3000.00')
    end

    it 'And a withdrawal of 500 on 14-01-2023' do
      account.withdraw(500.00, '14-01-2023')
      expect(account.print_balance).to eq('The current balance is 2500.00')
    end

    # it 'has all transactions stored as statements (newest first)' do
    #   expect(account.print_statements.length).to eq(4)
    #   expect(account.print_statements[0]).to eq('date || credit || debit || balance')
    #   expect(account.print_statements[1]).to eq('14-01-2023 || - || 500.00 || 2500.00')
    #   expect(account.print_statements[2]).to eq('13-01-2023 || 2000.00 || - || 3000.00')
    #   expect(account.print_statements[3]).to eq('10-01-2023 || 1000.00 || - || 1000.00')
    # end
  end
end
