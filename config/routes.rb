Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      namespace :items do
        get '/find_all',           to: 'finder#index'
        get '/find',               to: 'finder#show'
        get '/random',             to: 'random#show'
        get '/:id/invoice_items',  to: 'invoice_items#show'
        get '/:id/merchant',       to: 'merchants#show'
        get '/most_revenue',       to: 'most_revenue#index'
        get '/most_items',         to: 'most_items#index'
        get '/:id/best_day',       to: 'best_day#show'
      end

      namespace :invoices do
        get '/find_all',            to: 'finder#index'
        get '/find',                to: 'finder#show'
        get '/:id/invoice_items',   to: 'invoice_items#index'
        get '/:id/transactions',    to: 'transactions#index'
        get '/:id/items',           to: 'items#index'
        get '/:id/customer',        to: 'customer#show'
        get '/:id/merchant',        to: 'merchant#show'
        get '/random',              to: 'random#show'
      end

      namespace :invoice_items do
        get '/find_all',    to: 'finder#index'
        get '/find',        to: 'finder#show'
        get '/random',      to: 'random#show'
        get '/:id/invoice', to: 'invoice#show'
        get '/:id/item',    to: 'item#show'
      end

      namespace :transactions do
        get '/find_all',      to: 'finder#index'
        get '/find',          to: 'finder#show'
        get '/:id/invoice',   to: 'invoice#show'
        get '/random',        to: 'random#show'
      end

      namespace :customers do
        get '/find_all',           to: 'finder#index'
        get '/find',               to: 'finder#show'
        get '/:id/invoices',       to: 'invoices#index'
        get '/:id/transactions',   to: 'transactions#index'
        get '/random',             to: 'random#show'
      end

      namespace :merchants do
        get '/find_all',       to: 'finder#index'
        get '/find',           to: 'finder#show'
        get '/random',         to: 'random#show'
        get '/:id/invoices',   to: 'invoices#index'
        get '/:id/items',      to: 'items#index'
        get '/most_revenue',   to: 'most_revenue#index'
        get '/most_items',     to: 'most_items#index'
        get '/:id/revenue',    to: 'revenue#show'
      end

      resources :items, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      resources :merchants, only: [:index, :show]
      resources :transactions, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
      resources :customers, only: [:index, :show]
    end
  end
end
