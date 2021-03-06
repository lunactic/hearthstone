Hearthstone::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  get "welcome/index"
  # You can have the root of your site routed with "root"
  root to:'welcome#index'

  post 'data_loader/upload' => 'data_loader#upload'
  resources :cards
  devise_for :users
  resources :data_loader, :only => [:index, :upload]

  resources :users do
    get 'stat_entries/overview' => 'stat_entries#overview'
    post 'stat_entries/select_overview' => 'stat_entries#select_overview'
    #get 'decks/addCards/:id' => 'decks#addCards'
    #post 'decks/addCards/:deckId/:cardId' => 'decks#addCard', :as => :add_card
    #delete 'decks/addCards/:deckId/:cardId' => 'decks#removeCard', :as => :remove_card
    #get 'decks/addCards/:deckId/:cardId' => 'decks#search', :as => :search
    resources :stat_entries
    resources :decks do
      get 'add_cards/add_card/:card_id' => 'add_cards#add_card', :as => :add_card
      delete 'add_cards/remove_card/:card_id' => 'add_cards#remove_card', :as => :remove_card
      resources :add_cards do

      end
    end
  end


  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
