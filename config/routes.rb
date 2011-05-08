NestedResource::Application.routes.draw do

  root :to => "events#index"
  
  resources :events do
    resources :registrations
  end

end
