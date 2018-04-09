Rails.application.routes.draw do
  get 'upload_file/create'

  post "/graphql", to: "graphql#execute"
  post 'authenticate', to: 'authentication#authenticate'
  post 'upload', to: 'upload_file#create'
end
