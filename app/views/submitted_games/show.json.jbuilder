json.extract! @submitted_game, :id, :title, :status, :reason, :published_game_id
json.token form_authenticity_token