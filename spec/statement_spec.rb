require "statement"

describe Statement do
  describe "creating a statement" do
    let!(:statement) { Statement.new }
    it "creates a debit statement when a withdrawal is made" do
      debit_statement = statement.save_debit(100.00, "01/02/22", 1500.00)
      expect(debit_statement).to include(:date => "01/02/22", :debit => "100.00", :balance => "1500.00")
    end
  end
end