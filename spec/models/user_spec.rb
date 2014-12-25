require 'spec_helper'

describe User do

  before do 
  	@user = User.new(name: "Example User", email: "user@example.com")
  end

  subject { @user }

  it { should respond_to(:name) }
  #it "should respond to 'name'" do
  #	expect(@user).to respond_to(:name)
  #end

  it { should respond_to(:email) }

  it { should be_valid }
  #it "should be valid" do
  #	expect(@user).to be_valid
  #end

  describe "when name is not present" do
  	before { @user.name = " " }
  	it { should_not be_valid }
  end

  describe "when email is not present" do
  	before { @user.email = " " }
  	it { should_not be_valid }
  end
end
