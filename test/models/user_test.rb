require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Tianming Zhuang", email: "tianming.zhuang@gmail.com",
                    password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "    "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "    "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.name = "a" * 256
    assert_not @user.valid?
  end

  test "user with non-unique email should be invalid" do
    user2 = @user.dup
    @user.save
    assert_not user2.valid?
  end
  
  test "password should not be blank" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should not be too short" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "email should be downcased before save" do
    old_email = @user.email = "aVaLiDeMail@emaiL.com"
    @user.save
    assert_equal old_email.downcase, @user.reload.email
  end

  test "valid emails should be accepted" do
    valid_emails = %w[ asdf.dsfsfd@gmail.com bad-er3.EFDS.c@e-ef.c.ge a@a.a ]
    valid_emails.each do |email|
      @user.email = email
      assert @user.valid?, "#{email.inspect} should be valid"
    end
  end

  test "invalid emails should be rejected" do
    invalid_emails = %w[ sdf-@c.c sdf..@d.c ..@.. vdvd.@d.c user@example,com user_at_foo.org user.name@example.
                               foo@bar_baz.com foo@bar+baz.com ]
    invalid_emails.each do |email|
      @user.email = email
      assert_not @user.valid?, "#{email.inspect} should be invalid"
    end
  end
end
