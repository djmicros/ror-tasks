require 'active_record'

class TodoItem < ActiveRecord::Base

  belongs_to :todolist

  validates :title, :todo_list_id, :presence => true
  validates :description, :length => {   :minimum   => 0,
    :maximum   => 255,}
end
