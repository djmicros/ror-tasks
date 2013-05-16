class Account
  attr_accessor :balance
  attr_reader :currency

  def initialize(currency, balance = 0)
    raise IllegalArgument unless currency
    @currency = currency
    @balance = balance.nil? ? 0 : balance
  end
  
  def supply(amount)
    @balance += amount
    return self
  end
  
  def self.find(currency, accounts)
    accounts.find{ |a| a.currency == currency }
  end
end
