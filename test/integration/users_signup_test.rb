require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  setup do
    @data = { params: { user: { name: "Foo Bar",
                                  email: "foo@bar.com",
                                  password: "foobar",
                                  password_confirmation: "foobar" } } }

  end

  test "valid user should be saved" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, @data
    end
    follow_redirect!
    assert_template "users/show"
    assert is_logged_in?
    assert_not flash.empty?
  end

  test "blank name should not be saved" do
    get signup_path
    @data[:params][:user][:name] = ""
    assert_select 'form[action="/signup"]'
    assert_no_difference 'User.count' do
      post users_path, @data
    end

    assert_select "div#error_explanation"
    assert_select "div.field_with_errors"
  end
end
