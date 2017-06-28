Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      namespace :items do
        get 'find_all',           to: 'finder#index'
        get 'find',               to: 'finder#show'
        get 'random',             to: 'random#show'
        get ':id/invoice_items',  to: 'invoice_items#index'
        get ':id/merchant',       to: 'merchant#show'
      end

      namespace :invoices do
        get 'find_all', to: 'finder#index'
        get 'find',     to: 'finder#show'
        get 'random',   to: 'random#show'
      end

      namespace :invoice_items do
        get 'find_all',    to: 'finder#index'
        get 'find',        to: 'finder#show'
        get 'random',      to: 'random#show'
        get ':id/invoice', to: 'invoice#show'
        get ':id/item',    to: 'item#show'
      end

      namespace :transactions do
        get ':id/invoice',   to: 'invoice#show'
      end

      # namespace :invoices do
      #   get '/find', to: 'invoices#show'
      # end
      #
      # namespace :invoice_items do
      #   get '/find', to: 'invoice_items#show'
      # end

      resources :items, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      resources :merchants, only: [:index, :show]
      resources :transactions, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
      resources :customers, only: [:index, :show]
    end

  end
end
