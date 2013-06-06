require_relative 'test_helper'
require_relative '../lib/user'
require_relative '../lib/todolist'
require_relative '../lib/todoitem'

describe TodoList do
  include TestHelper
  
  it "should find list by prefix of title" do
    TodoList.create(:title => "Moja pierwsza lista", :user_id => 1)
	TodoList.create(:title => "fdsfdsfsdfdsfsd", :user_id => 1)
    find_todolist_by_prefix("Moja").should == TodoList.first
  end
  
  it "should find all lists that belong to a given User" do
    TodoList.create(:title => "Moja pierwsza lista", :user_id => 1)
	TodoList.create(:title => "fdsfdsfsdfdsfsd", :user_id => 1)
	TodoList.create(:title => "Moja pierwsza lista", :user_id => 2)
	TodoList.create(:title => "fdsfdsfsdfdsfsd", :user_id => 3)
    find_all_lists_of_user(1).should == [TodoList.find(1), TodoList.find(2)]
  end
  
  it "should find list by id and load its items" do
    TodoList.create(:title => "Moja pierwsza lista", :user_id => 1)
	TodoList.create(:title => "Moja pierwsza lista", :user_id => 2)
	TodoList.create(:title => "fdsfdsfsdfdsfsd", :user_id => 3)
	
	TodoItem.create(:title => "pierwszy item", :todo_list_id => 1)
	TodoItem.create(:title => "drugi item", :todo_list_id => 1)
	TodoItem.create(:title => "trzeci item", :todo_list_id => 1)
	
    get_items_from_list(1).should == [TodoItem.find(1), TodoItem.find(2), TodoItem.find(3)]
  end
  
  
  
    
  
end
