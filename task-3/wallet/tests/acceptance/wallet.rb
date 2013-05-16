require_relative './acceptance_helper'
require_relative './test_helper'

describe "Wallet" do
  include TestHelper
  context "user with EUR and PLN accounts" do
    specify "supplies EUR and PLN to the accounts" do
      set_balance eur: 50, pln: 25
      supply eur: 25, pln: 30
      get_balance(:eur).should == 75
      get_balance(:pln).should == 55
    end  
      
    specify "transfer all money from wallet to accounts" do
      set_wallet_balance eur: 10, pln: 30
      set_balance eur: 0, pln: 0
      transfer_all_money_to_accounts
      get_wallet_balance(:eur).should == 0
      get_wallet_balance(:pln).should == 0
      get_balance(:eur).should == 10
      get_balance(:pln).should == 30
    end
    
    specify "transfer given amount of money to account" do
      set_wallet_balance eur: 10, pln: 30
      set_balance eur: 0, pln: 0
      transfer_money_to_accounts eur: 5, pln: 10
      get_wallet_balance(:eur).should == 5
      get_wallet_balance(:pln).should == 20
      get_balance(:eur).should == 5
      get_balance(:pln).should == 10
    end
 
    specify "buy company_1 stocks without limit" do
      set_balance eur: 40, pln: 16
      set_stocks_balance :company_1, 0
      set_stocks_exchange_rate :company_1, :eur, 2
      buy_stocks :company_1, :eur
      get_stocks_balance(:company_1).should == 20
      get_wallet_balance(:eur).should == 0
    end
        
    specify "buy 6 company_1 stocks" do
      set_balance eur: 40
      set_stocks_balance :company_1, 0
      set_stocks_exchange_rate :company_1, :eur, 4
      buy_stocks :company_1, 6
      get_stocks_balance(:company_1).should == 6
      get_balance(:eur).should == 16
    end
    
    specify "sell all company_1 stocks" do
      set_balance eur: 40
      set_stocks_balance :company_1, 10
      set_stocks_exchange_rate :company_1, :eur, 2
      sell_all_stocks :company_1
      get_balance(:eur).should == 60
      get_stocks_balance(:company_1).should == 0
    end
    
    specify "sell six company_1 stocks" do
      set_balance eur: 40
      set_stocks_balance :company_1, 10
      set_stocks_exchange_rate :company_1, :eur, 2
      sell_stocks :company_1, 6
      get_balance(:eur).should == 52
      get_stocks_balance(:company_1).should == 4
    end
    
    specify "convert from EUR to PLN without limit" do
      set_balance :eur => 100, :pln => 0
      set_exchange_rate :eur, :pln, 4.15
      convert_money :eur, :pln
      get_balance(:eur).should == 0
      get_balance(:pln).should == 415
    end

    specify "convert from EUR to PLN with limit set to 50" do
      set_balance :eur => 100, :pln => 0
      set_exchange_rate :eur, :pln, 4.15
      convert_money_with_limit :eur, :pln, 50
      get_balance(:eur).should == 50
      get_balance(:pln).should == 205.75
    end
  end  
end
