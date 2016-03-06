json.extract! @submitted_game, :title, :status, :reason
json.token form_authenticity_token