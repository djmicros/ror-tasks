class Currency
  SYMBOLS = [:eur, :pln, :usd]
  
  attr_reader :shortcut
  
  def initialize(shortcut, options = {})
    raise IllegalArgument unless shortcut
    raise CurrencyNotSupported unless SYMBOLS.include?(shortcut.to_sym)
    @shortcut = shortcut.to_sym
  end
      
  def to_sym
    @shortcut.to_sym
  end    
  
end
