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
	@items[index]
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
	if @items[index].completed == true
	@items[index].completed = false
	else
	@items[index].completed = true
	end
  end
  
  def make_uncomplete (index)
  @items[index].completed = false
  end
  
  def change_desc (index, desc)
	@items[index].description = desc
  end
  
  def sort
	@items.sort! { |a,b| a.description.downcase <=> b.description.downcase }
  end
  
  def to_s
    (@items.collect { |item| item.formated }).join("\n")
  end

  
end
