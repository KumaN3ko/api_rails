Rails.application.routes.draw do

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "https://api.github.com/graphql", method: 'post'
  end

  post "/graphql", to: "graphql#execute"
  root to: 'home#home', as: 'root'
  get 'search(/:name)', to: 'home#search', as: 'search_path'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
