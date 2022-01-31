class Statement
  def save_debit(amount, date, balance)
    statement = {
      :date => date,
      :credit => "-",
      :debit => format_string(amount),
      :balance => format_string(balance)
    }
  end

  private
  def format_string(num)
    sprintf('%.2f', num)
  end
end