require 'test_helper'

class PublishedGameTest < ActiveSupport::TestCase
  test "current featured" do
    game = PublishedGame.featured
    assert_not_nil game, "Find featured game"
    
    next_game = published_games(:two)
    assert_not_nil next_game, "next game"
    assert_not next_game.current_feature, "next game not featured"
    
    next_game.make_featured
    assert next_game.current_feature, "next game now featured"
    
    load_next_game = PublishedGame.featured
    assert_equal(next_game.id, load_next_game.id, "next game is featured")
    load_game = PublishedGame.find(game.id)
    assert_not load_game.current_feature, "old game not featured"    
  end
end
