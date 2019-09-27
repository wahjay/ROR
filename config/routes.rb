# The Rails.application.routes.draw do ... end block that wraps your route definitions is
# required to establish the scope for the router DSL and must not be deleted.
Rails.application.routes.draw do
  # get 'welcome/index' tells Rails to map requests to http://localhost:3000/welcome/index
  # to the welcome controller's index action
  get 'welcome/index'


  # match route '/articles' to action 'articles#index' named by 'article'
  # this router must be written above the 'resouce :articles',  so it is matched first,
  # if not, the show action route will always be matched before the get

  get '/articles', to: 'articles#index' , as: 'article'
  resources :articles do
    resources :comments
  end

  #get '/articles', to: 'articles#index'
  # it asks the router to match it to a controller action.
  # this line has to written here so in the controller class,
  # Article.find(params[:id]) could work.

  # match route '/articles/:id' to this action 'articles#show'
  get '/articles/:id', to: 'articles#show'

  # match '/articles/:id' to action 'article#update'
  patch '/articles/:id', to: 'articles#update'

  # match route '/articles/:id/edit' to this action 'articles#edit
  get '/articles/:id/edit', to: 'articles#edit'

  # match route '/articles/:id' to action 'articles#destroy'
  delete '/articles/:id', to: 'articles#destroy'

  # match route to action
  # edit comments
  get '/articles/:id/comments/:id/edit', to: 'comments#edit'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # root 'welcome#index' tells Rails to map requests to the root of the application
  # to the welcome controller's index action
  root 'welcome#index'
end
