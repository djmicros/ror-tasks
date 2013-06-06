require_relative 'test_helper'
require_relative '../lib/user'
require_relative '../lib/todolist'
require_relative '../lib/todoitem'

describe TodoItem do
  include TestHelper
  
  it "should find items with a specific word in a description" do
  
    TodoList.create(:title => "Moja pierwsza lista", :user_id => 1)
	
    TodoItem.create(:title => "pierwszy item", :todo_list_id => 1, :description => "Opis pierwszy")
	TodoItem.create(:title => "drugi item", :todo_list_id => 1, :description => "Opis drugi")
	TodoItem.create(:title => "trzeci item", :todo_list_id => 1, :description => "Opis drugi")
	TodoItem.create(:title => "czwarty item", :todo_list_id => 1, :description => "Opis trzeci")
	
    find_item_by_description("drugi").should == TodoItem.find(2)
  end
  
  it "should find items with description longer than 100" do
  
    TodoList.create(:title => "Moja pierwsza lista", :user_id => 1)
    TodoItem.create(:title => "pierwszy item", :todo_list_id => 1, :description => "0123456789001234567890012345678900123456789001234567890012345678900123456789001234567890012345678900123456789001234567890")
	TodoItem.create(:title => "drugi item", :todo_list_id => 1, :description => "Opis drugi")
	TodoItem.create(:title => "trzeci item", :todo_list_id => 1, :description => "Opis drugi")
	TodoItem.create(:title => "czwarty item", :todo_list_id => 1, :description => "Opis trzeci")
	
    find_item_with_description_longer_than_100[0].should == TodoItem.find(1)
  end
  
  it "should find items with description longer than 100" do
  
    TodoList.create(:title => "Moja pierwsza lista", :user_id => 1)
    TodoItem.create(:title => "pierwszy item", :todo_list_id => 1, :description => "0123456789001234567890012345678900123456789001234567890012345678900123456789001234567890012345678900123456789001234567890")
	TodoItem.create(:title => "drugi item", :todo_list_id => 1, :description => "Opis drugi")
	TodoItem.create(:title => "trzeci item", :todo_list_id => 1, :description => "Opis drugi")
	TodoItem.create(:title => "czwarty item", :todo_list_id => 1, :description => "Opis trzeci")
	
    find_item_with_description_longer_than_100[0].should == TodoItem.find(1)
  end
    
  
end
