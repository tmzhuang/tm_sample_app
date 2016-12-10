require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title, "tm-sample-app"
    assert_equal full_title("Help"), "Help | tm-sample-app"
  end
end
