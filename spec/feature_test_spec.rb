# frozen_string_literal: true

require 'bankAccount'

# check full feature test (irb) in README.md
describe BankAccount do
  context 'basic user journey' do
    account = BankAccount.new
    double_1_credit = { date: '10-01-2023', balance: '1000.00', debit: nil, credit: '1000.00' }
    double_2_credit = { date: '13-01-2023', balance: '3000.00', debit: nil, credit: '2000.00' }
    double_3_debit = { date: '14-01-2023', balance: '2500.00', debit: '500.00', credit: nil }


    it 'Given a client makes a deposit of 1000 on 10-01-2023' do
      deposit = account.deposit(1000.00)

      expect(deposit[0][:balance]).to eq '1000.00'
    end

    it 'And a deposit of 2000 on 13-01-2023' do
      deposit2 = account.deposit(2000.00)

      expect(deposit2[1][:balance]).to eq '3000.00'
    end

    it 'And a withdrawal of 500 on 14-01-2023' do
      withdrawal = account.withdraw(500.00)

      expect(withdrawal[2][:balance]).to eq '2500.00'
    end

    it 'has all transactions stored as statements (newest first)' do
      account = BankAccount.new
      account.statement.statements << double_1_credit
      account.statement.statements << double_2_credit
      account.statement.statements << double_3_debit

      expect(account.print_statements.length).to be 4
      expect(account.print_statements[0]).to eq('date || credit || debit || balance')
      expect(account.print_statements[1]).to eq('14-01-2023 ||  || 500.00 || 2500.00')
      expect(account.print_statements[2]).to eq('13-01-2023 || 2000.00 ||  || 3000.00')
      expect(account.print_statements[3]).to eq('10-01-2023 || 1000.00 ||  || 1000.00')
    end
  end
end
