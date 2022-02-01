require "bankAccount"

describe BankAccount do
  
  describe "seeing and changing the balance of an account" do
    let!(:account) { BankAccount.new }

    context "the account has sufficient funds" do
      it "has a default balance of 0 when opened" do
        expect(account.print_balance).to include "0.00"
      end

      it "can receive money" do
        account.deposit(50.00, "01/01/22",)
        expect(account.print_balance).to include "50.00"
      end

      it "can withdraw money" do
        account.deposit(50.00, "01/01/22")
        account.withdraw(30.00, "02/01/22")
        expect(account.print_balance).to include "20.00"
      end
    end

    context "the account has insufficient funds" do
      it "can't have a balance below 0" do
        expect { account.withdraw(30.00, "02/01/22") }.to raise_error "Sorry, your balance is insufficient"
      end
    end
  end

  describe "seeing the statements" do
    let!(:account) { BankAccount.new }
    double_debit_st = {date: "01/01/22", balance: "50.00", debit: "50.00", credit: "-"}
    double_credit_st = {date: "02/01/22", balance: "20.00", debit: "-" , credit: "30.00"}

    context "the account has sufficient funds" do
      it "has no statement when just opened" do
        expect(account.print_statements.length).to be(1)
        expect(account.print_statements).to include("date || credit || debit || balance")
      end

      it "has 1 credit statement after a deposit" do
        account.statements.unshift(double_debit_st)
        expect(account.print_statements.length).to be(2)
        expect(account.print_statements[0]).to include("date || credit || debit || balance")
        expect(account.print_statements[1]).to include("01/01/22 || 50.00 || - || 50.00")
      end

      it "has 1 debit statement after a withdral" do
        account.statements.unshift(double_debit_st)
        account.statements.unshift(double_credit_st)
        expect(account.print_statements.length).to be(3)
        expect(account.print_statements[0]).to include("date || credit || debit || balance")
        expect(account.print_statements[1]).to include("02/01/22 || - || 30.00 || 20.00")
        expect(account.print_statements[2]).to include("01/01/22 || 50.00 || - || 50.00")
      end
    end

    context "the account has insufficient funds" do
      it "creates no statement - withdraw from an empty account" do
        expect { account.withdraw(30.00, "02/01/22") }.to raise_error "Sorry, your balance is insufficient"

        expect(account.print_statements.length).to be(1)
      end

      it "creates no statement - insufficient funds" do
        account.deposit(50.00, "01/01/22")
        expect { account.withdraw(60.00, "02/01/22") }.to raise_error "Sorry, your balance is insufficient"
        expect(account.print_balance).to include "50.00"
        expect(account.statements.length).to be(1)
      end
    end
  end
end