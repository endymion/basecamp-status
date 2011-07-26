BasecampStatus::Application.routes.draw do
 
  root :to => 'boards#index'
  resources :board

end
