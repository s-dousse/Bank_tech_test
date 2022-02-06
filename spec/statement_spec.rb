# frozen_string_literal: true

require 'statement'

describe Statement do
  describe '#save_statement' do
    let!(:statement) { Statement.new }

    it 'creates a credit statement when a deposit is made' do
      credit_statement = statement.save_statement(1000, 'credit', '02/02/22',)

      expect(credit_statement[0]).to eq(date: '02/02/22', debit: nil, credit: '1000.00', balance: '1000.00')
    end

    it 'creates a debit statement when a withdrawal is made' do
      statement.save_statement(1000, 'credit', '02/02/22')
      debit_statement = statement.save_statement(500, 'debit', '01/02/22')

      expect(debit_statement[1]).to eq(date: '01/02/22', debit: '500.00', credit: nil, balance: '500.00')
    end

    context 'the account has insufficient funds' do
      it "can't have a balance below 0" do
        expect { statement.save_statement(500, 'debit', '01/02/22') }.to raise_error 'Sorry, your balance is insufficient'
      end
    end
  end

  describe '#format_statements' do
    let!(:statement) { Statement.new }

    it 'adds a header only when printed not to the statements attribute' do
      formatted_statements = statement.format_statements

      expect(formatted_statements.length).to eq 1
      expect(formatted_statements[0]).to eq 'date || credit || debit || balance'

      expect(statement.statements).to eq []
    end

    it 'can format a credit statement' do
      statement.save_statement(1000, 'credit', '06/02/22')
      formatted_statements = statement.format_statements

      expect(formatted_statements.length).to eq 2
      expect(formatted_statements[1]).to eq '06/02/22 || 1000.00 ||  || 1000.00'
    end

    it 'can format a debit statement' do
      statement.save_statement(1000, 'credit', '06/02/22')
      statement.save_statement(300, 'debit', '07/02/22')
      formatted_statements = statement.format_statements

      expect(formatted_statements.length).to eq 3
      expect(formatted_statements[1]).to eq '07/02/22 ||  || 300.00 || 700.00'
    end

    it 'can format multiples statments (newest first)' do
      statement.save_statement(1000, 'credit', '06/02/22')
      statement.save_statement(300, 'debit', '07/02/22')
      statement.save_statement(500, 'credit', '08/02/22')
      statement.save_statement(100, 'debit', '10/02/22')
      formatted_statements = statement.format_statements
      
      expect(formatted_statements.length).to eq 5
      expect(formatted_statements[0]).to eq 'date || credit || debit || balance'
      expect(formatted_statements[1]).to eq '10/02/22 ||  || 100.00 || 1100.00'
      expect(formatted_statements[2]).to eq '08/02/22 || 500.00 ||  || 1200.00'
      expect(formatted_statements[3]).to eq '07/02/22 ||  || 300.00 || 700.00'
      expect(formatted_statements[4]).to eq '06/02/22 || 1000.00 ||  || 1000.00'
    end

    context 'the account has insufficient funds' do
      it "doesn't create a statement" do
        statement = Statement.new
        expect { statement.save_statement(300, 'debit', '07/02/22') }.to raise_error 'Sorry, your balance is insufficient'
        expect(statement.format_statements.length).to eq 1
      end
    end
  end
end
