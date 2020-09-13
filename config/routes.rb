Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :v1 do
    resources :book_authors
    resources :books
    resources :authors
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
