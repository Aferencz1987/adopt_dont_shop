Rails.application.routes.draw do
  get '/', to: 'application#welcome'

  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  get '/shelters/:id', to: 'shelters#show'
  post '/shelters', to: 'shelters#create'
  get '/shelters/:id/edit', to: 'shelters#edit'
  patch '/shelters/:id', to: 'shelters#update'
  delete '/shelters/:id', to: 'shelters#destroy'

  get '/pets', to: 'pets#index'
  get '/pets/:id', to: 'pets#show'
  get '/pets/:id/edit', to: 'pets#edit'
  patch '/pets/:id', to: 'pets#update'
  delete '/pets/:id', to: 'pets#destroy'

  get '/pet_applications/new', to: 'pet_applications#new'
  post '/pet_applications', to: 'pet_applications#create'
  get '/pet_applications', to: 'pet_applications#index'
  get '/pet_applications/:id', to: 'pet_applications#show'
  delete '/pet_applications/:id', to: 'pet_applications#destroy'
  patch '/pet_applications/:id/pets/:pet_id', to: 'pet_applications#connect_pet_to_app'
  patch '/pet_applications/:id/add_reason', to: 'pet_applications#update'

  get '/veterinary_offices', to: 'veterinary_offices#index'
  get '/veterinary_offices/new', to: 'veterinary_offices#new'
  get '/veterinary_offices/:id', to: 'veterinary_offices#show'
  post '/veterinary_offices', to: 'veterinary_offices#create'
  get '/veterinary_offices/:id/edit', to: 'veterinary_offices#edit'
  patch '/veterinary_offices/:id', to: 'veterinary_offices#update'
  delete '/veterinary_offices/:id', to: 'veterinary_offices#destroy'

  get '/veterinarians', to: 'veterinarians#index'
  get '/veterinarians/:id', to: 'veterinarians#show'
  get '/veterinarians/:id/edit', to: 'veterinarians#edit'
  patch '/veterinarians/:id', to: 'veterinarians#update'
  delete '/veterinarians/:id', to: 'veterinarians#destroy'

  get '/shelters/:shelter_id/pets', to: 'shelters#pets'
  get '/shelters/:shelter_id/pets/new', to: 'pets#new'
  post '/shelters/:shelter_id/pets', to: 'pets#create'

  get '/veterinary_offices/:veterinary_office_id/veterinarians', to: 'veterinary_offices#veterinarians'
  get '/veterinary_offices/:veterinary_office_id/veterinarians/new', to: 'veterinarians#new'
  post '/veterinary_offices/:veterinary_office_id/veterinarians', to: 'veterinarians#create'

  get '/admins/shelters', to: 'admin_shelters#index'
  patch '/admins/pet_applications/:id/pets/:pet_id/approved', to: 'admin_pet_applications#approved'
  patch '/admins/pet_applications/:id/pets/:pet_id/rejected', to: 'admin_pet_applications#rejected'
  get '/admins/pet_applications', to: 'admin_pet_applications#index'
  get '/admins/pet_applications/:id', to: 'admin_pet_applications#show'
end
