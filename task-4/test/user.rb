require_relative 'test_helper'
require_relative '../lib/user'
require_relative '../lib/todo_item'
require_relative '../lib/todo_list'

describe User do
  include TestHelper

    subject(:user)                  { User.create(name: name, surname: surname, email: email, password: password, password_confirmation: password_confirmation, terms_of_the_service: terms_of_the_service) }
    let(:name)                      { "Zygmunt" }
    let(:surname)                   { "Wazowy" }
    let(:email)                     { "zigi@gmail.com" }
    let(:password)                  { "0123456789" }
    let(:password_confirmation)     { "0123456789" }
    let(:terms_of_the_service)          { true }
    
  it "should have valid attributes" do
     user.should be_valid
  end
    
  context "with empty name" do
     let(:name) { nil }
     it { should_not be_valid }
  end
    
  context "with too long name" do
     let(:name) { "asdasdasdasdasdasdasdasdasasdasdasdasdasdasdasdasdasdasdasdasdasdasdasd" }
     it { should_not be_valid }
  end
    
    context "with empty surname" do
        let(:surname) { nil }
        it { should_not be_valid }
    end
    
    context "with too long surname" do
        let(:surname) { "asdasdasdasdasdasdasdasdasasdasdasdasdasdasdasdasdasdasdasdasdasdasdasd" }
        it { should_not be_valid }
    end
    
    context "with too short password" do
        let(:password) { "abc" }
        it { should_not be_valid }
    end
    
    context "with unconfirmed password" do
        let(:password)                  { "0123456789" }
        let(:password_confirmation)     { "abcdefghij" }
        it { should_not be_valid }
    end
    
    context "with unacepted terms of the service" do
        let(:terms_of_the_service) { false }
        it { should_not be_valid }
    end

    it "should have failed_login_count = 0" do
        user.failed_login_count.should == 0
    end
   
  context "with invalid email" do
      let(:email) { "invalid.email.com" }
      it { should_not be_valid }
  end


  it "should find user by surname" do
    user = User.find_by_surname("Mistrzunio")
    user.surname.should == "Mistrzunio"
    user.name.should == "Adrian3"
  end

  it "should find user by email" do
    user = User.find_by_email("djmicros@gmail.com")
    user.surname.should == "Kuciel"
    user.name.should == "Adrian"
  end

  it "should authenticate user using email and password (should use password encryption)" do 
     User.authenticate("djmicros@gmail.com", "0123456789").should == true
  end

  it "should find suspicious users with more than 2 failed_login_counts" do
    User.authenticate("djmicros@gmail.com", "zxcdsdv")
    User.authenticate("djmicros@gmail.com", "qwedsdr")
    User.authenticate("djmicros@gmail.com", "asdfggf")
    User.find_by_email("djmicros@gmail.com").failed_login_count.should == 3
    User.find_suspicious_users.count.should == 3
  end
    
  it "should group users by failed_login_counts" do
    User.group_suspicious_users.count.should == {0=>1, 4=>2}
  end
    
  it "find user by prefix of his/her surname" do
    User.find_by_prefix("Mistrz").surname.should == "Mistrzunio"
  end
end
