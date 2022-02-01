require "bankAccount"

describe BankAccount do
  
  describe "seeing and changing the balance of an account" do
    let!(:account) { BankAccount.new }

    context "the account has sufficient funds" do
      it "has a default balance of 0 when opened" do
        expect(account.print_balance).to include "0.00"
      end

      it "can receive money" do
        account.deposit(50.00, "01/01/22")
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
end