require "bankAccount"

describe BankAccount do
  
  describe "seeing and changing the balance of an account" do
    let!(:account) { BankAccount.new }

    it "has a default balance of 0 when opened" do
      expect(account.print_balance).to include "0.00"
    end

    it "can receive money" do
      account.deposit(50.00)
      expect(account.print_balance).to include "50.00"
    end

    it "can withdraw money" do
      account.deposit(50.00)
      account.withdraw(30.00)
      expect(account.print_balance).to include "20.00"
    end
  end
end