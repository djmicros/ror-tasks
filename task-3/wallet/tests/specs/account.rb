require_relative 'spec_helper'
require_relative '../../lib/account'
require_relative '../../lib/exceptions'

describe Account do
  subject(:account)            { Account.new(currency, balance) }
  let(:currency)               { Struct.new(:shortcut).new(:eur) }
  let(:balance)                { 50 }
  
  let(:accounts)              { [account_1, account_2] }
  let(:account_1)             { Struct.new(:currency, :balance).new(currency_1, balance_1) }
  let(:account_2)             { Struct.new(:currency, :balance).new(currency_2, balance_2) }
  let(:money)                 { { currency_1 => balance_1, currency_2 => balance_2 } }
  let(:currency_1)            { :eur }
  let(:currency_2)            { :pln }
  let(:balance_1)             { 25 }
  let(:balance_2)             { 50 }

  it "should raise an exception if currency is not defined" do
    expect{ Account.new(nil, balance) }.to raise_error(IllegalArgument)
  end

  it "should return the account currency and balance" do
    account.currency.shortcut.should == :eur
    account.balance.should == 50
  end
  
  context "with nil balance" do
    let(:balance) { nil }
    it "should create account with empty balance (for poor people)" do
      account.balance.should == 0
    end
  end

  context "with no balance given" do
    it "should create empty account" do
      account = Account.new(currency)
      account.balance.should == 0
    end
  end

  it "should supply account with given amount" do
    account.supply(25)
    account.balance.should == 75
  end
  
  it "should find account with given currency" do
    account = Account.find(currency_1, accounts)
    account.currency.should == currency_1
    account.balance.should == balance_1
  end
  
  it "should return nil if no account was found" do
    Account.find(:usd, accounts).should == nil
  end
end
