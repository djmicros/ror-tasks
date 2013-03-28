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
  if item == nil
  raise IllegalArgument 
  else
  if item[:title] == "" || item[:title].length <6
  false
  else
  @parameters[:db].add_todo_item(item)
  if item[:title].length > 255 
    item[:title] = item[:title][0...254]
      end
  @parameters[:socialnetwork].spam(0, item[:title])
  end
  end
  end
  
  def first
  @parameters[:db].get_todo_item(0)
  end
  
  def last
  size = @parameters[:db].items_count
  if size == 0
  @parameters[:db].get_todo_item(size)
  else
  number = size-1
  @parameters[:db].get_todo_item(number)
  end
  end
  
  def toggle_state (index)
      item = @parameters[:db].get_todo_item(index)
  if item == nil
  raise IllegalArgument 
  else
  if @parameters[:db].todo_item_completed?(index) == false
  @parameters[:db].complete_todo_item(index,true)
  if item[:title].length > 255 
    item[:title] = item[:title][0...254]
      end
  @parameters[:socialnetwork].spam(1, item[:title])
  else
  @parameters[:db].complete_todo_item(index,false)
  end
  end
  end
  
  def spam(finished, title)
  if finished == 0
    true
  elsif finished == 1
    true
  end
  end
  
end
