require 'spec_helper'

describe User do

  it "has a valid factory" do 
    expect(FactoryGirl.build(:user)).to be_valid 
  end

  it "has right attributes" do
    user = FactoryGirl.create(:user)
    expect(user).to respond_to(:first_name)
    expect(user).to respond_to(:last_name)
    expect(user).to respond_to(:email)
    expect(user).to respond_to(:zipcode)
    expect(user).to respond_to(:teaching_radius)
  end

  it "should require an email address" do
    expect(FactoryGirl.build(:user, email: nil)).to_not be_valid
  end

  it "should require a first name" do
    expect(FactoryGirl.build(:user, first_name: nil)).to_not be_valid
  end

  it "should require a last name" do
    expect(FactoryGirl.build(:user, last_name: nil)).to_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_user@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = FactoryGirl.build(:user, :email => address)
      expect(valid_email_user).to be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = FactoryGirl.build(:user, :email => address)
      expect(invalid_email_user).to_not be_valid
    end
  end

  it "should have a can_host attribute" do
    new_user = FactoryGirl.build(:user)
    expect(new_user).to respond_to(:can_host)
    expect(new_user.can_host).to satisfy { |host| [true, false].include?(host)}
  end

  it "should have multiple interests" do
    new_user = FactoryGirl.build(:user)
    expect(new_user).to respond_to(:interests)
  end  

  it "should reject duplicate email addresses" do
    FactoryGirl.create(:user, email: "abc123@abc.com")
    user_with_duplicate_email = FactoryGirl.build(:user, email: "abc123@abc.com")
    expect(user_with_duplicate_email).to_not be_valid
  end

  it "should reject email addresses identical up to case" do
    FactoryGirl.create(:user, :email => "ABC@ABC.COM")
    user_with_duplicate_email = FactoryGirl.build(:user, email: "abc@abc.com")
    expect(user_with_duplicate_email).to_not be_valid
  end


end
