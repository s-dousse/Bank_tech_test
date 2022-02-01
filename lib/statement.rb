require_relative 'bankAccount'

class Statement
  
  def initialize
    @statements = []
  end

  def save_statement(amount, date, balance, status)
    statement = {
      :date => date,
      :balance => format_string(balance)
    }
    if is_a_debit?(status)
      statement.merge!(:debit => format_string(amount))
      statement.merge!(:credit => "-")
    else
      statement.merge!(:debit => "-")
      statement.merge!(:credit => format_string(amount))
    end
    @statements.unshift(statement)
  end

  def print_statements
    delimiter = " || "
    header = "date || credit || debit || balance"
    list = @statements.map do |statement|
      "#{statement[:date]}" + delimiter + "#{statement[:debit]}"  + delimiter + "#{statement[:credit]}"  + delimiter + "#{statement[:balance]}"
    end
    list.unshift(header)
  end

  private
  def format_string(num)
    sprintf('%.2f', num)
  end

  def is_a_debit?(status)
    status == true
  end
end