class Statement

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
    statement
  end

  private
  def format_string(num)
    sprintf('%.2f', num)
  end

  def is_a_debit?(status)
    status == true
  end
end