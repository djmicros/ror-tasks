require_relative 'spec_helper'
require_relative '../../lib/currency'
require_relative '../../lib/exceptions'

describe Currency do
  subject(:currency)            { Currency.new(shortcut) }
  let(:shortcut)               { :eur }

  it "should raise an exception if currency is not defined" do
    expect{ Currency.new(nil) }.to raise_error(IllegalArgument)
  end

  it "should raise an exception if currency is supported" do
    expect{ Currency.new(:zomg) }.to raise_error(CurrencyNotSupported)
  end
  
  it "should return the currency shortcut" do
    currency.shortcut.should == :eur
  end

end
