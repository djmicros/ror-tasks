require_relative 'test_helper'
require_relative '../lib/user'

describe User do
  include TestHelper

  it "should persist itself" do
    User.create(:name => "Adrssian", :surname => "Kuciel", :email => "djmicros@gmail.com", :password => "0123456789", :password_confirmation => "0123456789", :terms_of_the_service => "yes")
	User.create(:name => "Adrian", :surname => "Kuciel", :email => "djmicrosss@gmail.com", :password => "0123456789", :password_confirmation => "0123456789", :terms_of_the_service => "yes")
	
    User.last.name.should == "Adrian"
    User.count.should == 2
  end
  
  it "should find user by surname" do
    User.create(:name => "Adrian", :surname => "Kuciel", :email => "djmicros@gmail.com", :name => "Adrian", :password => "0123456789", :password_confirmation => "0123456789", :terms_of_the_service => "yes")
    find_user_by_surname("Kuciel").should == User.first
  end
  
  it "should find user by prefix of surname" do
    User.create(:name => "Adrian", :surname => "Kuciel", :email => "djmicros@gmail.com", :name => "Adrian", :password => "0123456789", :password_confirmation => "0123456789", :terms_of_the_service => "yes")
    find_user_by_prefix("Kuc").should == User.first
  end
  
  it "should find user by email" do
    User.create(:name => "Adrian", :surname => "Kuciel", :email => "djmicros@gmail.com", :name => "Adrian", :password => "0123456789", :password_confirmation => "0123456789", :terms_of_the_service => "yes")
    find_user_by_email("djmicros@gmail.com").should == User.first
  end
  
  it "should authenticate user by email and password" do
    User.create(:name => "Adrian", :surname => "Kuciel", :email => "djmicros@gmail.com", :name => "Adrian", :password => "0123456789", :password_confirmation => "0123456789", :terms_of_the_service => "yes")
    authenticate_user("djmicros@gmail.com", "0123456789").should == User.first
  end
  
  it "should find suspicious users" do
    User.create(:name => "Adrssian", :surname => "Kuciel", :email => "djmicrsos@gmail.com", :password => "0123456789", :password_confirmation => "0123456789", :terms_of_the_service => "yes")
	User.create(:name => "Adrian", :surname => "Kuciel", :email => "djmicrosss@gmail.com", :password => "0123456789", :password_confirmation => "0123456789", :terms_of_the_service => "yes")
	User.create(:name => "Adrssian", :surname => "Kuciel", :email => "djmficros@gmail.com", :password => "0123456789", :password_confirmation => "0123456789", :terms_of_the_service => "yes")
	User.create(:name => "Adrian", :surname => "Kuciel", :email => "djmicraosss@gmail.com", :password => "0123456789", :password_confirmation => "0123456789", :terms_of_the_service => "yes")
	
	   
	register_failed_login(1)
	register_failed_login(1)
	register_failed_login(1)

	first_suspicious_user = find_suspicious_users.first
	
	first_suspicious_user.should == User.first
  end
  
  it "should group users by number of failed login attempts" do
    User.create(:name => "Adrssian", :surname => "Kuciel", :email => "djmicrsos@gmail.com", :password => "0123456789", :password_confirmation => "0123456789", :terms_of_the_service => "yes")
	User.create(:name => "Adrian", :surname => "Kuciel", :email => "djmicrosss@gmail.com", :password => "0123456789", :password_confirmation => "0123456789", :terms_of_the_service => "yes")
	User.create(:name => "Adrssian", :surname => "Kuciel", :email => "djmficros@gmail.com", :password => "0123456789", :password_confirmation => "0123456789", :terms_of_the_service => "yes")
	User.create(:name => "Adrian", :surname => "Kuciel", :email => "djmicraosss@gmail.com", :password => "0123456789", :password_confirmation => "0123456789", :terms_of_the_service => "yes")

	register_failed_login(1)
    register_failed_login(2)
	register_failed_login(2)
	register_failed_login(2)
	register_failed_login(3)
	register_failed_login(3)

	group_by_failed_logins.first.should == User.find(2)
  end
  
  
end
