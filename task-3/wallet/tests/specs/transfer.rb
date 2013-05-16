require_relative 'spec_helper'
require_relative '../../lib/services/transfer'
require_relative '../../lib/exceptions'

describe Transfer do
  let(:wallet)                { Struct.new(:pockets).new(currency_1 => balance_1) }
  let(:accounts)              { [account_1, account_2] }
  let(:account_1)             { Struct.new(:currency, :balance).new(currency_1, balance_1) }
  let(:account_2)             { Struct.new(:currency, :balance).new(currency_2, balance_2) }
  let(:money)                 { { currency_1 => balance_1, currency_2 => balance_2 } }
  let(:currency_1)            { :eur }
  let(:currency_2)            { :pln }
  let(:balance_1)             { 25 }
  let(:balance_2)             { 50 }

  
  it "should transfer all amount of currency from wallet to account" do
    mock(wallet).get_balance(currency_1) { balance_1 }
    mock(wallet).remove(currency_1, balance_1) { wallet.pockets[currency_1] -= balance_1; true }
    mock(account_1).supply(balance_1) { account_1.balance += balance_1 }
    
    Transfer.new(wallet, account_1).transfer_to_account
    wallet.pockets[currency_1].should == 0
    account_1.balance.should == balance_1 * 2
  end
    
  it "should transfer given amount of money of currency from wallet to account" do
    mock(wallet).remove(currency_1, 10) { wallet.pockets[currency_1] -= 10; true }
    mock(account_1).supply(10) { account_1.balance += 10 }
    
    Transfer.new(wallet, account_1, 10).transfer_to_account
    wallet.pockets[currency_1].should == 15
    account_1.balance.should == balance_1 + 10
  end  
    
end
