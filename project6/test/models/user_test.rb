require 'test_helper'

class UserTest < ActiveSupport::TestCase

  #TODO: Make a test so that only one credential can be true
  
  def setup
    @user = User.new(name: "Example User", email: "hubbell.64@osu.edu", password: "foobar", password_confirmation: "foobar",
                      status: "Student");
  end

  test "should be valid" do
    assert @user.valid?;
  end

  test "name should be present" do
    @user.name = "    ";
    assert_not @user.valid?;
  end

  # Uncomment and comment validate :status_auth in user.rb to test
  #test "email should be present" do
    #@user.email = "    ";
    #assert_not @user.valid?;
  #end

  test "name should not be too long" do
    @user.name = "a" * 51;
    assert_not @user.valid?;
  end

  # Uncomment and comment validate :status_auth in user.rb to test
  #test "email should not be too long" do
    #@user.email = "a" * 249 + "osu.edu";
    #assert_not @user.valid?;
  #end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[hubbell.64@osu.edu HUBBELL.64@osu.edu hubbell.64@OSU.edu hubbell.64@osu.EDU hubbell.64@OSU.EDU];
    valid_addresses.each do |valid_address|
      @user.email = valid_address;
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  # Uncomment and comment validate :status_auth in user.rb to test
  #test "email validation should reject invalid addresses" do
    #invalid_addresses = %w[user29@osu.edu USER,35@osu.edu user.47@OSU. user.19@osuEDU user.98OSU.EDU user.165@osuedu user198osuedu];
    #invalid_addresses.each do |invalid_address|
      #@user.email = invalid_address;
      #assert_not @user.valid?, "#{invalid_address.inspect} should be invalid";
    #end
  #end
  
  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

end