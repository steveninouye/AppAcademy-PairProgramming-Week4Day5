Rails.application.routes.draw do
  get 'users/index'
  get 'users/new'
  get 'users/create'
  get 'users/show'
  get 'users/destroy'
  get 'users/update'
  get 'users/edit'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
