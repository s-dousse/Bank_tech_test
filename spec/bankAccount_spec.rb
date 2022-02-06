# frozen_string_literal: true

require 'bankAccount'

describe BankAccount do
  let!(:account) { BankAccount.new }
  it 'can receive a deposit' do
    # account = BankAccount.new

    deposit = account.deposit(500, '05/02/22')
    expect(deposit[0].balance).to eq 500.00
  end

  it 'lets the user make a withdrawal' do
    # account = BankAccount.new

    account.deposit(500, '05/02/22')
    withdrawal = account.withdraw(200, '06/02/22')
    expect(withdrawal[0].balance).to eq 100.00
  end

  describe '#statements' do
    let!(:account) { BankAccount.new }
    double_debit_st = { date: '01/01/22', balance: '50.00', debit: '50.00', credit: '-' }
    double_credit_st = { date: '02/01/22', balance: '20.00', debit: '-', credit: '30.00' }

    context 'the account has sufficient funds' do
      it 'has no statement when just opened' do
        expect(account.print_statements.length).to eq(1)
        expect(account.print_statements[0]).to eq('date || credit || debit || balance')
      end

      it 'has 1 credit statement after a deposit' do
        account.statements << double_credit_st
        
        expect(account.print_statements.length).to be(2)
        expect(account.print_statements[0]).to eq('date || credit || debit || balance')
        expect(account.print_statements[1]).to eq('02/01/22 || - || 30.00 || 20.00')
      end

      it 'has 1 debit statement after a withdral' do
        account.statements << double_debit_st

        expect(account.print_statements.length).to eq(2)
        expect(account.print_statements[0]).to eq('date || credit || debit || balance')
        expect(account.print_statements[1]).to eq('01/01/22 || 50.00 || - || 50.00')
      end

      it 'has different statements after a couple of transactions' do
        
        account.statements.unshift(double_debit_st)

        expect(account.print_statements.length).to eq(2)
        expect(account.print_statements[0]).to eq('date || credit || debit || balance')
        expect(account.print_statements[1]).to eq('01/01/22 || 50.00 || - || 50.00')
      end
    end

    # context 'the account has insufficient funds' do
    #   xit 'creates no statement - withdraw from an empty account' do
    #     expect { account.withdraw(30.00, '02/01/22') }.to raise_error 'Sorry, your balance is insufficient'

    #     expect(account.print_statements.length).to eq(1)
    #   end

    #   xit 'creates no statement - insufficient funds' do
    #     account.deposit(50.00, '01/01/22')
    #     expect { account.withdraw(60.00, '02/01/22') }.to raise_error 'Sorry, your balance is insufficient'
    #     expect(account.print_balance).to eq('The current balance is 50.00')
    #     expect(account.statements.length).to eq(1)
    #   end
    # end
  end
end
