# frozen_string_literal: true

require 'bankAccount'

describe BankAccount do
  let!(:account) { BankAccount.new }

  it 'can receive a deposit' do
    deposit = account.deposit(500)

    expect(deposit[0][:balance]).to eq '500.00'
  end

  it 'lets the user make a withdrawal' do
    account.deposit(500)
    withdrawal = account.withdraw(200)

    expect(withdrawal[1][:balance]).to eq '300.00'
  end

  describe '#statements' do
    let!(:account) { BankAccount.new }
    double_credit_st = { date: '01/01/22', balance: '100.00', debit: nil, credit: '100.00' }
    double_debit_st = { date: '02/01/22', balance: '50.00', debit: '50.00', credit: nil }
    double_debit_st_two = { date: '04/01/22', balance: '40.00', debit: '10.00', credit: nil }

    context 'the account has sufficient funds' do
      it 'has no statement when just opened' do
        expect(account.print_statements.length).to eq(1)
        expect(account.print_statements[0]).to eq('date || credit || debit || balance')
      end

      it 'has 1 credit statement after a deposit' do
        account.statement.statements << double_credit_st
        
        expect(account.print_statements.length).to be(2)
        expect(account.print_statements[0]).to eq('date || credit || debit || balance')
        expect(account.print_statements[1]).to eq('01/01/22 || 100.00 ||  || 100.00')
      end

      it 'has 1 debit statement after a withdral' do
        account.statement.statements << double_debit_st

        expect(account.print_statements.length).to eq(2)
        expect(account.print_statements[0]).to eq('date || credit || debit || balance')
        expect(account.print_statements[1]).to eq('02/01/22 ||  || 50.00 || 50.00')
      end

      it 'has different statements after a couple of transactions' do
        account.statement.statements << double_credit_st
        account.statement.statements << double_debit_st
        account.statement.statements << double_debit_st_two
        
        expect(account.print_statements.length).to eq 4
        expect(account.print_statements[0]).to eq('date || credit || debit || balance')
        expect(account.print_statements[1]).to eq('04/01/22 ||  || 10.00 || 40.00')
        expect(account.print_statements[2]).to eq('02/01/22 ||  || 50.00 || 50.00')
        expect(account.print_statements[3]).to eq('01/01/22 || 100.00 ||  || 100.00')
      end
    end

    context 'the account has insufficient funds' do

      it 'creates no statement - withdraw from an empty account' do
        expect { account.withdraw(30.00) }.to raise_error 'Sorry, your balance is insufficient'

        expect(account.print_statements.length).to eq 1
      end

      it 'creates no statement - insufficient funds' do
        account.deposit(50.00)
        
        expect { account.withdraw(60.00) }.to raise_error 'Sorry, your balance is insufficient'
        expect(account.print_statements.length).to eq 2
      end
    end
  end
end
