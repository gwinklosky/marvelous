json.extract! @game, :id, :title, :description, :active, :user_id, :username
json.token form_authenticity_token
