json.user_scores @user_scores, :username, :points
json.game_scores @game_scores, :game_name, :username, :points
json.feature_scores @feature_scores, :game_name, :username, :points