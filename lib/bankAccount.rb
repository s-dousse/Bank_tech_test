class BankAccount
  DEFAULT_BALANCE = 0.00

  def initialize()
    @balance = DEFAULT_BALANCE
  end

  def print_balance
    "The current balance is #{sprintf('%.2f', @balance)}"
  end

  def deposit(amount) 
    @balance += amount
  end

  def withdraw(amount) 
    @balance -= amount
  end 
end
