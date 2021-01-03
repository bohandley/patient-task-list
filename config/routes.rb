Rails.application.routes.draw do
  
  resources :selected_tasks
  resources :instructions
  
  resources :patients do
  	resources :instructions
  end

  root :to => "task_lists#index"

  resources :task_lists do
  	resources :task_items 
	end

	resources :task_items
  post 'item_archive/:id' => 'task_items#archive'
  post 'list_archive/:id' => 'task_lists#archive'
  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
