require 'active_record'
require 'active_record/fixtures'
require 'yaml'

ActiveRecord::Base.establish_connection(YAML::load_file("config/db.yml"))

module TestHelper
  def self.included(child)
    # WARNING: we use transactional fixtures only. This helper should not be
    # used to test transaction dependent code.
    child.around do |example|
      tables = Dir["test/fixtures/*.yml"].map{|fn| File.basename(fn,".yml") }
      ActiveRecord::Fixtures.create_fixtures("test/fixtures/",tables)
      ActiveRecord::Base.transaction do
        example.run
        raise ActiveRecord::Rollback
      end
    end
  end
  
  
  
  def find_todolist_by_prefix(prefix) 
    found = TodoList.where('title LIKE ?', "%#{prefix}%")
	return found[0]
  end
  
  def find_all_lists_of_user(index) 
    found = TodoList.where(:user_id => index)
	return found
  end
  
  def get_items_from_list(index)
	found = TodoItem.where(:todo_list_id => index)
  end

  def find_item_by_description(word) 
    found = TodoItem.where('description LIKE ?', "%#{word}%")
	return found[0]
  end
  
  def find_item_with_description_longer_than_100
    i = 1
	num = TodoItem.count
	found = []
		until i >= num  do
            if TodoItem.find(i).description.length > 100 
			  found.push(TodoItem.find(i))
			end
            i +=1
		end		
	return found
  end
  
end
