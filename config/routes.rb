BasecampStatus::Application.routes.draw do
 
  root :to => 'boards#index'
  resources :board
 
  match "/loading" => "boards#loading" 
  match "/reload" => "boards#reload" 
  match "/updateFinish" => "boards#cachedUpdateFinished"
 
  match "/board/persons" => "boards#get_person_by_project"
  match "/board/persons/update" => "boards#update_todo_item_assigned"
  match "/board/due_date/update" => "boards#update_todo_item_due_date"
  match "/board/completed/update" => "boards#mark_item_as_completed"
  
end
