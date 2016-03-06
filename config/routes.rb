Rails.application.routes.draw do
  resources :users do
    collection do
      get 'published'
    end
    member do
      post 'clense'
    end
  end

  resources :submitted_games do
    collection do
      get 'submitted'
    end
    member do
      get 'words'
      post 'publish'
    end
  end

  get 'games' => 'games#index', as: 'games'
  get 'game_status' => 'games#game_status'
  get 'games/:id' => 'games#show', as: 'game'
  get 'games/:id/edit' => 'games#edit', as: 'edit_game'
  post 'games/:id' => 'games#update', as: 'update_game'
  post 'share_scores' => 'games#share_scores'
  get 'top_scores' => 'games#top_scores'
  get 'featured_game' => 'games#featured', as: 'featured'
  get 'published_games/:id' => 'games#published', as: 'published_games'
  get 'games/:id/words' => 'games#show_words', as: 'game_words'

  root 'welcome#index', as: 'welcome'
end
