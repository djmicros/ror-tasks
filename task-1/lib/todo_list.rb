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
  
  def item(index)
    	if (index >= 0 and index < @items.size)
	@items[index]
	else
      raise IndexOutOfBounds
    end
  end
	
  def first
	@items.first
  end
  
  def last
	@items.last
  end
  
  def completed?(index)
  	if (index >= 0 and index < @items.size)
    @items[index].completed
	else
      raise IndexOutOfBounds
    end
  end
  
  def complete(index)
  	if (index >= 0 and index < @items.size)
  	@items[index].completed = true
	else
      raise IndexOutOfBounds
    end
  end
  
  def completed 
	@items.select { |item| item.completed }
  end
  
  def uncompleted
    @items.reject { |item| item.completed }
  end
  
  def remove (index)
	if (index >= 0 and index < @items.size)
      @items.delete_at(index)
    else
      raise IndexOutOfBounds
    end
  end
  
  def remove_completed
    @items.reject! { |item| item.completed }
  end
  
  def reverse(one, two)
      [one, two].each do |index|
      raise IndexOutOfBounds if (index < 0 or index >= @items.size)
      end
	first = @items[one]
	second = @items[two]
	@items[one] = second
	@items[two] = first
  end
  
  def reverse_all
  @items.reverse!
  end
  
  def toggle (index)
      if (index >= 0 and index < @items.size)
	if @items[index].completed == true
	@items[index].completed = false
	else
	@items[index].completed = true
	end
	  	else
      raise IndexOutOfBounds
    end
  end
  
  def make_uncomplete (index)
    if (index >= 0 and index < @items.size)
  @items[index].completed = false
  	else
      raise IndexOutOfBounds
    end
  end
  
  def change_desc (index, desc)
  if (index >= 0 and index < @items.size)
	@items[index].description = desc
	else
      raise IndexOutOfBounds
    end
  end
  
  def sort
	@items.sort! { |a,b| a.description.downcase <=> b.description.downcase }
  end
  
  def to_s
    (@items.collect { |item| item.formated }).join("\n")
  end

  
end
