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
  if @parameters[:db].get_todo_item(index) == nil
  raise IllegalArgument 
  else
  if @parameters[:db].todo_item_completed?(index) == false
  @parameters[:db].complete_todo_item(index,true)
  else
  @parameters[:db].complete_todo_item(index,false)
  end
  end
  end
  
  def spam(finished, description)
  if finished == 0
  body = "https://www.facebook.com/dialog/feed?
  app_id=458358780877780&
  link=https://todolist.com/users/1/task/1&
  picture=http://todolist.com/users/1/avatar.jpg&
  name=Just added new task!
  caption=Task:&
  description="+description+""
  redirect_to body
  return "Just added new task!"
  elsif finished == 1
  body = "https://www.facebook.com/dialog/feed?
  app_id=458358780877780&
  link=https://todolist.com/users/1/task/1&
  picture=http://todolist.com/users/1/avatar.jpg&
  name=Just finished task!
  caption=Task:&
  description="+description+""
  redirect_to body
  return "Just finished my task!"
  end
  end
  
end
