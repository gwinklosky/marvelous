require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:two)
  end

  test "make admin" do
    assert_not @user.admin
    @user.make_admin
    assert @user.admin
  end

  test "clense name" do
    old = @user.username
    
    if @user.published_game_scores.empty?
      @user.published_game_scores << published_game_scores(:user_two_1)
    end
    assert_equal old, @user.published_game_scores.first.username
    @user.clense_username
    puts @user.username 
  end

end
