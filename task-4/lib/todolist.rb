require 'active_record'

class TodoList < ActiveRecord::Base

  belongs_to :user
  has_many :todoitems

  validates :title, :user_id, :presence => true
end
