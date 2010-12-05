Sinwizualizator::Application.routes.draw do
  resources :images do
    collection do
      post :find
    end
  end
  root :to => "images#index"
end
