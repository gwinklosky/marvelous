json.array!(@submitted_games) do |submitted_game|
  json.extract! submitted_game, :id, :title, :user_id, :status
  json.url submitted_game_url(submitted_game, format: :json)
end