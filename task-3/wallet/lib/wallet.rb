require_relative './account'
require_relative './currency'
require_relative './services/lib'

class Wallet

  attr_reader :pockets

  def initialize(money = {})
    @pockets = {}
    set_balance(money)
  end

  def set_balance(money = {})
    money.each do |currency, amount|
      @pockets[currency.to_sym] = amount
    end
  end

  def get_balance(currency)
    @pockets[currency.to_sym]
  end

  def remove(currency, amount)
    raise NotEnoughMoney if @pockets[currency.to_sym].nil? || @pockets[currency.to_sym] < amount
    @pockets[currency.to_sym] -= amount
    return true
  end
  
  def transfer_all_to_accounts(accounts)
    @pockets.each do |currency, amount|
      transfer_to_account(Account.find(currency, accounts), currency, amount)
    end
  end
  
  def transfer_to_accounts(accounts, money)
    money.each do |currency, amount|
      transfer_to_account(Account.find(currency, accounts), currency, amount)
    end
  end
  
  protected
  
  def transfer_to_account(account, currency, amount)
    Transfer.new(self, account, amount).transfer_to_account unless account.nil?    
  end
end
