require "statement"

describe Statement do
  describe "creating a statement" do
    let!(:statement) { Statement.new }

    it "creates a debit statement when a withdrawal is made" do
      debit_statement = statement.save_debit(100, "01/02/22", 1500)
      expect(debit_statement).to include(:date => "01/02/22", :debit => "100.00", :credit => "-", :balance => "1500.00")
    end

    it "creates a credit statement when a deposit is made" do
      credit_statement = statement.save_credit(150, "02/02/22", 2000)
      expect(credit_statement).to include(:date => "02/02/22", :debit => "-", :credit => "150.00", :balance => "2000.00")
    end
  end
end