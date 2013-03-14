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
	

  
end