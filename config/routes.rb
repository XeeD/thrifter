Thrifter::Application.routes.draw do

  # Admin backend
  namespace :admin do
    root :to => "admin#homepage"

    resources :brands, except: :show

    resources :products, except: :show do
      resources :photos, except: [:show], controller: "product_photos" do
        collection { post :sort }
      end

      resources :replacements, only: [:index, :create, :destroy], controller: "product_replacements"

      resources :params, controller: "product_param_items"

      resources :categorizations, controller: "product_categorizations", only: [:index, :destroy] do
        collection do
          post :add_shop_to
          get :edit_alternative
          put :update_alternative
        end
        member do
          get :edit_preferred
        end
      end
    end

    resources :param_templates do
      resources :groups, controller: "param_groups", except: :index do
        collection { post :sort }
      end
      resources :param_items
    end

    resources :shops, except: :show do
      member do
        get :deletion_confirmation
      end

      resources :news_items, except: :show
      resources :categories, except: :show
      resources :articles, except: :show
    end

    resources :documents

    # Admistation of categories - choose which shop's categories to administrate
    match "kategorie/vyber-obchodu" => "categories#choose_shop", as: "categories"
    match "novinky/vyber-obchodu" => "news_items#choose_shop", as: "news_items"
    match "clanky/vyber-obchodu" => "articles#choose_shop", as: "articles"
  end

  # Application frontend
  root :to => "root#index"

  match "/:category_url/:product_url(/:section)" => "products#show"
  match "/:category_url/"             => "categories#index"
end