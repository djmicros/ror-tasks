class TodoList

  # Initialize the TodoList with +items+ (empty by default).
  def initialize(parameters=[])
  @parameters = parameters
  raise IllegalArgument if parameters[:db].nil?
  end
  
  def empty?
  @parameters[:db].items_count == 0
  end
  
  def size
  @parameters[:db].items_count
  end
  
  def << (item)
  if item[:title] == ""
  false
  else
  @parameters[:db].add_todo_item(item)
  end
  end
  
  def first
  @parameters[:db].get_todo_item(0)
  end
  
  def last
  size = @parameters[:db].items_count
  number = size-1
  @parameters[:db].get_todo_item(number)
  end
  
  def toggle_state (index)
  if @parameters[:db].todo_item_completed?(index) == false
  @parameters[:db].complete_todo_item(index,true)
  else
  @parameters[:db].complete_todo_item(index,false)
  end
  end
  
end
