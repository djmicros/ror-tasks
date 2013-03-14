class TodoList

  # Initialize the TodoList with +items+ (empty by default).
  def initialize(items=[])
    if items==nil then raise(IllegalArgument) end
   	@items=items
	@complete=[]
	@complete[0]=false
  end
  
  def empty?
	@items.empty?
  end
    
  def size
	@items.size
  end
   
  def <<(item_description)
  	@items << item_description
	@complete[@items.size]=false
  end
  
  def last
  	@items.last
  end
  
  def first
  	@items.first
  end
  
  def completed?(num)
	@complete[num]
  end
  
  def complete(num)
  	@complete[num]=true
  end
  
	def completed
	@complete.select{|x| x = "true"}
	end
	
	def uncompleted
	@complete.select{|x| x = "false"}
	end
	
	def remove_item(num)
	@items.delete_at(num)
	end
	
	def remove_complete
	@complete.reject!
	end

	def revert(num1,num2)
	first = @items[num1]
	second = @items[num2]
	@items[num1] = second
	@items[num2] = first
	end

	def revert_all
	@items.reverse
	end
end
