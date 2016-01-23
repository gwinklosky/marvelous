require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "make admin" do
    user = users(:two)
    assert_not user.admin
    user.make_admin
    assert user.admin
  end
end
