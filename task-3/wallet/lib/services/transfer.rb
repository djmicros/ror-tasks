class Transfer
  def initialize(wallet, account, amount = nil) 
    @wallet = wallet
    @account = account
    @currency = @account.currency
    @amount = amount || wallet.get_balance(@currency)
  end
  
  def transfer_to_account
    if @wallet.remove(@currency, @amount)
      @account.supply(@amount)
      return true
    end
    return false
  end

  def transfer_from_account
    return true
  end
end
