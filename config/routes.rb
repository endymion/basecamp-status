BasecampStatus::Application.routes.draw do
 
  root :to => 'boards#index'
  resources :board
 
  match "/board/persons" => "boards#get_person_by_project"
  match "/board/persons/update" => "boards#update_todo_item_assigned"
end
