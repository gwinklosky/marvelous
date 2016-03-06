json.extract! @game, :id, :title, :description, :active, :user_id, :username, :word_list
json.token form_authenticity_token