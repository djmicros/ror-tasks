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
  
  
  def find_user_by_surname(surname) 
    found = User.where(:surname=> surname)
	return found[0]
  end
  
  def find_user_by_prefix(prefix) 
    found = User.where('surname LIKE ?', "%#{prefix}%")
	return found[0]
  end
  
  def find_user_by_email(email) 
    found = User.where(:email=> email)
	return found[0]
  end
  
  def authenticate_user(email, password) 
    user = User.find_by_email(email)
	return user.authenticate(password)
  end
  
  def register_failed_login(index)
    user = User.find(index)
	current_count = user.failed_login_count
    user.update_attribute(:failed_login_count, current_count + 1)
  end
  
  def find_suspicious_users
	users = User.where('failed_login_count > 2')
  end
  
  def group_by_failed_logins
    users = User.order("failed_login_count DESC")
  end
 
  

  
end
