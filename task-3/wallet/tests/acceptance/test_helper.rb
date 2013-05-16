require_relative '../../lib/wallet'

module TestHelper
  def set_balance(accounts)
    @accounts ||= []
    accounts.each do |currency,balance|
      @accounts << Account.new(currency,balance)
    end
  end

  def set_exchange_rate(currency_1, currency_2, exchange_rate)
  end

  def convert_money(from_currency,to_currency)
  end

  def convert_money_with_limit(from_currency,to_currency,limit)
  end

  def get_balance(currency)
    find_account(currency).balance
  end

  def find_account(currency)
    @accounts.find{ |a| a.currency == currency }
  end

  def find_rate(from_currency,to_currency)
    @rates.find{ |r| r.from_currency == from_currency && 
        r.to_currency == to_currency }
  end

  def supply(money)
    money.each do |currency, amount|
      find_account(currency).supply(amount)
    end
  end

  def set_wallet_balance(money)
    @wallet ||= Wallet.new
    @wallet.set_balance(money)
  end
  
  def transfer_all_money_to_accounts()
    @wallet.transfer_all_to_accounts(@accounts)
  end
  
  def transfer_money_to_accounts(money)
    @wallet.transfer_to_accounts(@accounts, money)
  end
  
  def get_wallet_balance(currency)
    @wallet.get_balance(currency)
  end

  def set_stocks_balance(company_name, balance)
  end

  def set_stocks_exchange_rate(company_name, currency, amount)
  end

  def buy_stocks(company_name, amount) 
  end

  def get_stocks_balance(company_name)
  end

  def sell_all_stocks(company_name)
  end

  def sell_stocks(company_name, amount)
  end
end
