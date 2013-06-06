class CreateTodoitems < ActiveRecord::Migration
  def change
    create_table :todo_items do |t|
      t.string :title
	  t.string :description
	  t.date :date_due
      t.integer :todo_list_id
    end
  end
end
