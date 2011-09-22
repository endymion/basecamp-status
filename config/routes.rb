BasecampStatus::Application.routes.draw do
 
  root :to => 'boards#index'
  resources :board
 
  match "/board/persons" => "boards#get_person_by_project"
  match "/board/persons/update" => "boards#update_todo_item_assigned"
  match "/board/due_date/update" => "boards#update_todo_item_due_date"
end
