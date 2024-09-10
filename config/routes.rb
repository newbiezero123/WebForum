Rails.application.routes.draw do
  devise_for :users

  resources :forums do
    resources :comments

    member do
      post "like"
    end
  end

  root "forums#index"
end
