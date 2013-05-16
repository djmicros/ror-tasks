require_relative 'spec_helper'
require_relative '../../lib/wallet'
require_relative '../../lib/exceptions'

describe Wallet do
  subject(:wallet)            { Wallet.new(money) }
  let(:money)                 { { currency_1 => balance_1, currency_2 => balance_2 } }
  let(:currency_1)              { :eur }
  let(:currency_2)              { :pln }
  let(:balance_1)               { 25 }
  let(:balance_2)               { 50 }
  
  let(:accounts)              { [account_1, account_2] }
  let(:account_1)             { Struct.new(:currency, :balance).new(currency_1, balance_1) }
  let(:account_2)             { Struct.new(:currency, :balance).new(currency_2, balance_2) }
  
  it "should create wallet from given money" do
    wallet.get_balance(currency_1).should == balance_1
    wallet.get_balance(currency_2).should == balance_2
  end

  it "should set balance of currencies when given money" do
    wallet = Wallet.new
    wallet.set_balance(money)
    wallet.get_balance(currency_1).should == balance_1
    wallet.get_balance(currency_2).should == balance_2
  end
  
  it "should remove given amount of money in given currency" do
    wallet.remove(currency_1, 10)
    wallet.get_balance(currency_1).should == balance_1 - 10
  end
  
  it "should raise exception when to much money is going to be removed" do
    expect{ wallet.remove(currency_1, 100) }.to raise_error(NotEnoughMoney)
  end
  
  context "with no account of given currency" do  
    let(:accounts)  { [account_1] }
    it "should not transfer this currency" do
      mock(Transfer).new(wallet, account_1, balance_1) { true }
      mock(true).transfer_to_account { account_1.balance += balance_1; wallet.pockets[currency_1] = 0 }
      
      wallet.transfer_all_to_accounts(accounts)
      wallet.get_balance(currency_1).should == 0
      wallet.get_balance(currency_2).should == balance_2
      account_1.balance.should == balance_1 * 2
      accounts.length.should == 1
    end
  end
  
  it "should transfer all money to accounts" do
    mock(Transfer).new(wallet, account_1, balance_1) { true }
    mock(true).transfer_to_account { account_1.balance += balance_1; wallet.pockets[currency_1] = 0 }
    mock(Transfer).new(wallet, account_2, balance_2) { true }
    mock(true).transfer_to_account { account_2.balance += balance_2; wallet.pockets[currency_2] = 0 }
    
    wallet.transfer_all_to_accounts(accounts)
    wallet.get_balance(currency_1).should == 0
    wallet.get_balance(currency_2).should == 0
    account_1.balance.should == balance_1 * 2
    account_2.balance.should == balance_2 * 2
  end

  it "should transfer given amount of money money to accounts" do
    mock(Transfer).new(wallet, account_1, 10) { true }
    mock(true).transfer_to_account { account_1.balance += 10; wallet.pockets[currency_1] -= 10 }
    
    wallet.transfer_to_accounts(accounts, currency_1 => 10)
    wallet.get_balance(currency_1).should == balance_1 - 10
    wallet.get_balance(currency_2).should == balance_2
    account_1.balance.should == balance_1 + 10
    account_2.balance.should == balance_2
  end
end
