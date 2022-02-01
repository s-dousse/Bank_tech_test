require "statement"

describe Statement do
  describe "creating a statement" do
    let!(:statement) { Statement.new }

    it "creates a debit statement when a withdrawal is made" do
      debit_statement = statement.save_statement(100, "01/02/22", 1500, true)
      expect(debit_statement).to include(:date => "01/02/22", :debit => "100.00", :credit => "-", :balance => "1500.00")
    end

    it "creates a credit statement when a deposit is made" do
      credit_statement = statement.save_statement(150, "02/02/22", 2000, false)
      expect(credit_statement).to include(:date => "02/02/22", :debit => "-", :credit => "150.00", :balance => "2000.00")
    end
  end

  describe "printing a statement" do
    let!(:statement) { Statement.new }

    context "only 1 statement" do
      it "prints the statement (debit)" do
        statement.save_statement(100, "31/01/22", 1500, true)
        expect(statement.print_statements[1]).to include("31/01/22 || 100.00 || - || 1500.00")
      end

      it "return the statement (credit)" do
        statement.save_statement(150, "03/02/22", 2000, false)
        expect(statement.print_statements[1]).to include("03/02/22 || - || 150.00 || 2000.00")
      end
    end

    context "multiple statements" do
      it "returns all the statement (debit and credit)" do
        statement.save_statement(100, "31/01/22", 1500, true)
        statement.save_statement(1500, "01/02/22", 3000, true)
        statement.save_statement(500, "02/02/22", 2500, false)
        expect(statement.print_statements[1]).to include("31/01/22 || 100.00 || - || 1500.00")
        expect(statement.print_statements[2]).to include("01/02/22 || 1500.00 || - || 3000.00")
        expect(statement.print_statements[3]).to include("02/02/22 || - || 500.00 || 2500.00")
      end
    end
  end
end