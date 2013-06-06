require 'active_record'

class User < ActiveRecord::Base
  
  has_secure_password
  
  has_many :todolists
  has_many :todoitems, :through => :todolists

  validates :name, :surname, :password, :presence => true
  validates :name, :length => { :maximum => 20 }
  validates :surname, :length => { :maximum => 30 }
  validates :password, :length => { :minimum => 10 }
  validates :email, :uniqueness => true,
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Wrong email!" }
  validates :terms_of_the_service, :acceptance => { :accept => 'yes' }
  validates :password_confirmation, presence: true
  validates_confirmation_of :password
  
  
 
  

  
end
