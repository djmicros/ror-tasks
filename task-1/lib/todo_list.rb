class TodoList

class Item
  	
    def initialize(description=nil)
  	  @description = description
  	  @completed = false
  	end

    def to_s
      @description.to_s
    end

    def formated
      if @completed
        completion = "x"
      else
        completion = " "
      end
      "- [#{completion}] #{@description}"
    end

  	attr_accessor :description, :completed
  end
  
  
  # Initialize the TodoList with +items+ (empty by default).
  def initialize(items=[])
  	raise IllegalArgument if items.nil?
  	@items = []
    items.each do |item|
      @items.push Item.new(item)
    end
  end
  
  def empty?
	@items.empty?
  end
  
  def size
	@items.size
  end
  
  def <<(item)
  	@items.push(Item.new(item))
  end
  
  def first
	@items.first
  end
  
  def last
	@items.last
  end
  
  def completed?(index)
    @items[index].completed
  end
  
  def complete(index)
  	@items[index].completed = true
  end
  
  
end
